import requests
from bs4 import BeautifulSoup
from datetime import datetime
from supabase import create_client, Client
import logging
import traceback

# ⚙️ Configura modo de reseteo
MODO_RESETEO = True  # True = borra toda la tabla antes de insertar

# Configuración de logs
logging.basicConfig(
    filename='noticias.log',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

# Configura Supabase
SUPABASE_URL = "https://sbbddlhuflacpqnrvpyb.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU"
supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# Si activado, borra todas las noticias antes de insertar nuevas
if MODO_RESETEO:
    try:
        supabase.table("noticias").delete().neq("id", 0).execute()
        logging.info("🧹 Todas las noticias han sido eliminadas de Supabase.")
    except Exception as e:
        logging.error("❌ Error al borrar noticias:")
        logging.error(traceback.format_exc())

# URLs a procesar
urls = [
    "https://cdeamistad.com/actualidad/",
    "https://cdeamistad.com/actualidad/page/2/?et_blog"
]

def parse_fecha(texto):
    try:
        return datetime.strptime(texto, "%b %d, %Y").isoformat()
    except ValueError:
        return None

def obtener_contenido_completo(url_detalle):
    try:
        response = requests.get(url_detalle)
        detalle_soup = BeautifulSoup(response.text, 'html.parser')
        entry_content = detalle_soup.find("div", class_="entry-content")

        if not entry_content:
            return "", None

        # 📷 Buscar imagen grande justo después del <p class="post-meta">
        imagen_url = None
        post_meta = entry_content.find("p", class_="post-meta")
        if post_meta:
            siguiente = post_meta.find_next_sibling()
            while siguiente and siguiente.name != 'img':
                siguiente = siguiente.find_next_sibling()
            if siguiente and siguiente.name == 'img':
                srcset = siguiente.get("srcset")
            if srcset:
                imagenes = []
                for parte in srcset.split(","):
                    try:
                        url, size = parte.strip().rsplit(" ", 1)
                        size = int(size.replace("w", ""))
                        imagenes.append((size, url))
                    except:
                        continue
                if imagenes:
                    imagen_url = max(imagenes)[1]
            else:
                imagen_url = siguiente.get("src") or siguiente.get("data-src")


        # 📑 Extraer texto y detectar formularios sospechosos
        texto_elementos = []
        formulario_detectado = False
        for elem in entry_content.find_all(['p', 'li', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']):
            texto = elem.get_text(strip=True)
            if texto.lower() in ['si', 'no']:
                formulario_detectado = True
                continue
            texto_elementos.append(texto)

        texto = "\n\n".join(texto_elementos)

        # 📝 Si hay formulario, añadir enlace al final
        if formulario_detectado:
            texto += f"\n\n📝 Puedes rellenar el formulario aquí: {url_detalle}"

        return texto, imagen_url
    except Exception as e:
        logging.error(f"❌ Error al obtener contenido de {url_detalle}: {e}")
        return "", None

# Procesar cada página
for url in urls:
    try:
        response = requests.get(url)
        soup = BeautifulSoup(response.text, 'html.parser')
        articles = soup.find_all("article", class_="et_pb_post")

        for article in articles:
            try:
                titulo_tag = article.find("h2", class_="entry-title").find("a")
                titulo = titulo_tag.get_text(strip=True)
                url_noticia = titulo_tag["href"]

                # Verificar si ya existe
                if not MODO_RESETEO:
                    existe = supabase.table("noticias").select("id").eq("titulo", titulo).execute()
                    if existe.data:
                        logging.info(f"⚠️ Noticia ya existente: {titulo}")
                        continue

                fecha_tag = article.find("p", class_="post-meta").find("span", class_="published")
                fecha_str = fecha_tag.get_text(strip=True)
                fecha = parse_fecha(fecha_str)

                imagen_tag = article.find("div", class_="et_pb_image_container")
                img = imagen_tag.find("img") if imagen_tag else None
                imagen_url = img.get("src") or img.get("data-src") if img else None

                resumen_tag = article.find("div", class_="post-content-inner")
                resumen = resumen_tag.get_text(strip=True) if resumen_tag else ""

                contenido, imagen_detalle = obtener_contenido_completo(url_noticia)
                if not contenido:
                    contenido = resumen

                imagen_url = imagen_detalle or imagen_url


                imagen_url = imagen_detalle or imagen_url  # Prioriza la imagen interna


                noticia = {
                    "titulo": titulo,
                    "contenido": contenido,
                    "imagen": imagen_url,
                    "fecha": fecha
                }

                resultado = supabase.table("noticias").insert(noticia).execute()

                if resultado.data:
                    logging.info(f"✅ Noticia insertada: {titulo}")
                else:
                    logging.warning(f"⚠️ No se insertó la noticia: {titulo} | Resultado: {resultado}")
            except Exception as e:
                logging.error("❌ Error procesando una noticia:")
                logging.error(traceback.format_exc())
    except Exception as e:
        logging.error(f"❌ Error cargando la URL: {url}")
        logging.error(traceback.format_exc())
