# DisparosWebcam — Webcam Photo-Booth Game (VB6 + Flash)

An interactive photo-booth installation developed by Mediterrania Multimedia (circa 2008). Visitors faced the webcam and the kiosk "took a shot" of them: the captured frame was cropped, converted to grayscale and alpha-blended (pixel by pixel, using FreeImage) onto a pre-designed poster template (`plantilla.png`, with a cut-out silhouette), and the composed image was instantly printed. The Flash UI (`interfaz.swf`) also let the user pick one of the background music tracks from the `musica/` folder before the shot.

Main components (in `desarrollo/`):

- **`juego/`** — the Visual Basic 6 application (`Disparos.vbp`, `Form1.frm`): webcam capture through the custom `CaptureWindow.dll`, image composition with **FreeImage 3.10** (`modFreeImage.bas` VB6 wrapper, `FreeImage.dll`), direct printing, and the ShockwaveFlash ActiveX UI (FSCommands `FIRST/NEXT/PREV/CAPTURA/SALIR`).
- **`libs/`**, **`test/`** — support libraries/docs (`FreeImage3100.pdf`) and Flash camera experiments (`weedcam.fla`).
- **`instalador/`**, **`distribucion/`** — the Visual Basic 6 Package & Deployment Wizard output (SETUP.EXE + CAB, `SETUP.LST` manifests).

> **This project is shared ONLY for educational purposes. Its use, direct or derived, for professional or economic purposes is not permitted.**

For security reasons, some parts of the project may have been edited or removed.

## Requirements / How to run

- **OS:** Windows XP-era environment (full-screen, borderless kiosk application).
- **Tooling:** Visual Basic 6 to open/compile `desarrollo/juego/Disparos.vbp`; Adobe Flash 8/9-era IDE to edit `interfaz.fla`.
- **Runtime dependencies:** Visual Basic 6 runtime (`msvbvm60.dll`), **FreeImage 3.10** (`FreeImage.dll`), **Flash 9 debug ActiveX** (`FlDbg9c.ocx` — the release build bundles it), `scrrun.dll` (Scripting Runtime), and a default printer on the machine.
- **Run:** the easiest way is the final deliverable attached as a **GitHub Release asset** (`entregas/definitivos/` split into `directo` — portable runtime, `fuente` — FLA sources, and `setup` — MSI/PDW installers plus Flash / PDF-printer redistributables). Alternatively, run `desarrollo/juego/Disparar.exe` next to its assets (`interfaz.swf`, `plantilla.png`, `musica/`, `config.ini`).
- **Config:** `config.ini` holds volume levels (`volumenEspera`, `volumenJuego`) and timing (`tiempoPreparado`, `tiempoCaptura`).

## DISCLAIMER

This software is provided "as is", without any warranty of any kind, express or implied. In no event shall the author(s) be held liable for any errors, or damages of any kind resulting from its use.

> **AI training**: the use of the content of this repository (code, assets, documentation) to train or fine-tune machine learning models or AI systems is expressly **not permitted**. All of the repository is licensed under CC-BY-NC-4.0 (see the `LICENSE` file).

---

# DisparosWebcam — Juego fotomatón con webcam (VB6 + Flash)

Instalación interactiva de fotomatón desarrollada por Mediterrania Multimedia (hacia 2008). El visitante se colocaba frente a la cámara y el quiosco le "disparaba": el fotograma capturado se recortaba, se pasaba a escala de grises y se componía (pixel a pixel, con FreeImage) sobre una plantilla de cartel prediseñada (`plantilla.png`, con silueta recortada), y la imagen compuesta se imprimía al instante. La interfaz Flash (`interfaz.swf`) permitía además elegir una de las pistas de música de fondo de la carpeta `musica/` antes del disparo.

Componentes principales (en `desarrollo/`):

- **`juego/`** — la aplicación Visual Basic 6 (`Disparos.vbp`, `Form1.frm`): captura de webcam mediante la DLL propia `CaptureWindow.dll`, composición de imagen con **FreeImage 3.10** (wrapper VB6 `modFreeImage.bas`, `FreeImage.dll`), impresión directa, y la UI en control ActiveX ShockwaveFlash (FSCommands `FIRST/NEXT/PREV/CAPTURA/SALIR`).
- **`libs/`**, **`test/`** — librerías y documentación de apoyo (`FreeImage3100.pdf`) y experimentos Flash de cámara (`weedcam.fla`).
- **`instalador/`**, **`distribucion/`** — la salida del Package & Deployment Wizard de Visual Basic 6 (SETUP.EXE + CAB, manifiestos `SETUP.LST`).

> **Este proyecto se comparte SOLO con valor educativo. No está permitido su uso (directo o derivado) para fines profesionales o económicos.**

Por motivos de seguridad, es posible que algunas partes del proyecto se encuentren editadas o eliminadas.

## Requisitos / Cómo ejecutar

- **SO:** entorno de la era Windows XP (aplicación quiosco a pantalla completa, sin bordes).
- **Herramientas:** Visual Basic 6 para abrir/compilar `desarrollo/juego/Disparos.vbp`; IDE de la era Flash 8/9 para editar `interfaz.fla`.
- **Dependencias de ejecución:** runtime de Visual Basic 6 (`msvbvm60.dll`), **FreeImage 3.10** (`FreeImage.dll`), **ActiveX de Flash 9 debug** (`FlDbg9c.ocx` — el entregable lo incluye), `scrrun.dll` (Scripting Runtime), y una impresora por defecto configurada en la máquina.
- **Ejecución:** la vía más sencilla es el entregable final adjunto como **asset de GitHub Release** (`entregas/definitivos/` repartido en `directo` — runtime portable, `fuente` — fuentes FLA, y `setup` — instaladores MSI/PDW más redistributables de Flash / impresora PDF). Alternativamente, ejecutar `desarrollo/juego/Disparar.exe` junto a sus recursos (`interfaz.swf`, `plantilla.png`, `musica/`, `config.ini`).
- **Configuración:** `config.ini` define volúmenes (`volumenEspera`, `volumenJuego`) y tiempos (`tiempoPreparado`, `tiempoCaptura`).

## AVISO

Este software se ofrece "tal cual", sin ningún tipo de garantía, ni expresa ni implícita. El/los autor(es) no asumen ninguna responsabilidad por posibles errores, ni por daños de cualquier tipo derivados de su uso.

> **Entrenamiento de IA**: no se permite expresamente el uso del contenido de este repositorio (código, recursos, documentación) para entrenar o ajustar (*fine-tune*) modelos de aprendizaje automático o sistemas de IA. Todo el repositorio se publica con licencia CC-BY-NC-4.0 (ver el archivo `LICENSE`).
