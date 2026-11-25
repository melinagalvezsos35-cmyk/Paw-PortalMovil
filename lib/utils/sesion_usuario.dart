class SesionUsuario {
  static String nombre = '';
  static String correo = '';

  static void iniciarSesion({required String nuevoNombre, required String nuevoCorreo}) {
    nombre = nuevoNombre.trim().isNotEmpty
        ? nuevoNombre.trim()
        : nuevoCorreo.split('@').first; // Si solo inició sesión con correo, toma el usuario antes del @
    correo = nuevoCorreo.trim();
  }

  static void cerrarSesion() {
    nombre = '';
    correo = '';
  }
}