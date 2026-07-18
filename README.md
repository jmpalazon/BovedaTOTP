# Bóveda TOTP

Tus códigos de verificación en dos pasos, en tu PC y solo en tu PC.

**Bóveda TOTP** es una aplicación gratuita para Windows que genera los códigos de
verificación en dos pasos (TOTP, RFC 6238) de tus cuentas sin depender del móvil.
Funciona completamente sin conexión: nada sale de tu equipo.

Desarrollada por [José Mª Palazón](https://josemariapalazon.es).

## Características

- **Cifrado total**: secretos, nombres de cuentas, carpetas y colores se guardan en un
  único fichero cifrado con AES-256-GCM. La clave se deriva de tu contraseña maestra
  con PBKDF2-SHA256 (300.000 iteraciones). Sin la contraseña, el fichero no revela
  ni cuántas cuentas contiene.
- **Importación desde Google Authenticator**: sube una captura del QR de exportación
  (formato `otpauth-migration://`, descodificado en local) y trae todas tus cuentas
  de golpe. También admite secretos Base32 y URIs `otpauth://totp/` sueltas.
- **Carpetas personalizables** con nombre y color, buscador y edición de cuentas.
- **Bloqueo automático** tras 5 minutos de inactividad y **limpieza del portapapeles**
  30 segundos después de copiar un código.
- **Copias de seguridad** exportables (el fichero exportado también va cifrado).
- **Sin nube, sin cuentas, sin telemetría, sin publicidad.** El ejecutable pesa
  menos de 2 MB porque usa el WebView2 que Windows ya incluye.

## Tecnologías

JavaScript puro (sin frameworks) · [Neutralino.js](https://neutralino.js.org) ·
Web Crypto API · AES-256-GCM · PBKDF2 · TOTP/HMAC (RFC 6238) ·
Protocol Buffers (importación de Google Authenticator) ·
[jsQR](https://github.com/cozmo/jsQR) · WiX/msitools (instalador MSI)

## Compilar desde el código

Requisitos: [Node.js](https://nodejs.org) 18 o superior.

```bash
npm install -g @neutralinojs/neu
git clone https://github.com/jmpalazon/BovedaTOTP.git
cd BovedaTOTP
neu update        # descarga los binarios de Neutralino y genera resources/js/neutralino.js
neu run           # ejecutar en modo desarrollo
neu build --release   # generar dist/ con los ejecutables
```

El ejecutable de Windows queda en `dist/BovedaTOTP/BovedaTOTP-win_x64.exe`
(distribúyelo siempre junto a `resources.neu`).

### Generar el instalador MSI

En Linux o WSL, con `msitools` y `wixl` instalados:

```bash
./scripts/build-msi.sh 1.2.0
```

## Modelo de datos y almacenamiento

- **Modo portable**: si existe una bóveda `.storage` junto al ejecutable, se usa esa
  (la carpeta completa puede moverse a un pendrive u otro PC).
- **Modo instalado** (MSI): la bóveda se guarda en `%APPDATA%\BovedaTOTP\vault.json`
  y sobrevive a actualizaciones y desinstalaciones.
- En el navegador (abriendo `resources/index.html` directamente), se usa
  `localStorage`. Para esa modalidad conviene incrustar `js/jsqr.min.js` en el HTML
  y así obtener un único fichero autocontenido.

## Modelo de seguridad

El cifrado protege los datos **en reposo**: quien copie el fichero de la bóveda no
puede leer nada sin la contraseña maestra. Como cualquier gestor de este tipo, no
protege frente a malware activo en el equipo (un keylogger capturaría la contraseña
al teclearla) ni frente a contraseñas maestras débiles. Usa una frase larga.

Si encuentras un problema de seguridad, por favor repórtalo de forma privada a
través de [josemariapalazon.es](https://josemariapalazon.es) antes de publicarlo.

## Apoya el proyecto

La aplicación es totalmente gratuita. Si te resulta útil, puedes apoyar este y
otros proyectos con una donación desde el menú ☰ → Créditos de la propia aplicación.

## Licencia

[MIT](LICENSE) © 2026 José Mª Palazón
