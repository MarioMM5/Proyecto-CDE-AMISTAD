package cde.amistad.cde_amistad

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // 🔥 Establecer el splash screen antes de cargar Flutter
        setTheme(R.style.LaunchTheme)
        super.onCreate(savedInstanceState)
    }
}
