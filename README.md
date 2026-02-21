# 📱 Non-Custodial Wallet

![Flutter Version](https://img.shields.io/badge/Flutter-%5E3.11.0-blue.svg?style=flat&logo=flutter)
![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg?style=flat&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg)

Una aplicación móvil desarrollada en **Flutter** que funciona como una billetera de criptomonedas sin custodia (Non-Custodial Wallet), inspirada en la interfaz y experiencia de usuario de Trust Wallet.

El proyecto está diseñado con una arquitectura limpia y robusta, enfocada en la seguridad, la gestión descentralizada de activos y el rendimiento fluido.

---

## ✨ Características Principales

- 🔐 **Billetera Sin Custodia:** El usuario tiene el control total de sus claves privadas y frases semilla (BIP39/BIP32).
- 🪙 **Soporte Multicadena:** Integración con Bitcoin (vía `bdk_flutter`) y redes EVM / Ethereum (vía `web3dart`).
- 📈 **Datos del Mercado:** Visualización en tiempo real de los precios y el estado del mercado de criptomonedas.
- 🛡️ **Seguridad Local:** Almacenamiento seguro de credenciales y claves utilizando `flutter_secure_storage`.
- 🌍 **Internacionalización:** Soporte nativo multilingüe (Español e Inglés).
- 🎨 **Interfaz Moderna:** Diseño oscuro (Dark Theme) elegante, responsivo y fácil de usar.

---

## 🛠️ Tecnologías y Arquitectura

El proyecto emplea las mejores prácticas y los estándares modernos del desarrollo en Flutter:

### Core & UI
* **[Flutter](https://flutter.dev/):** Framework principal para desarrollo UI multiplataforma.
* **[GoRouter](https://pub.dev/packages/go_router):** Gestión de navegación y enrutamiento declarativo.
* **[Google Fonts](https://pub.dev/packages/google_fonts):** Tipografías modernas integradas.

### Gestión de Estado & Inyección de Dependencias
* **[Flutter BLoC](https://pub.dev/packages/flutter_bloc):** Manejo de estados predecible y escalable (`WalletCubit`, `MarketCubit`).
* **[GetIt](https://pub.dev/packages/get_it):** Localizador de servicios para la inyección de dependencias (DI).

### Blockchain & Criptografía
* **[web3dart](https://pub.dev/packages/web3dart):** Interacción con contratos inteligentes y la blockchain de Ethereum.
* **[bdk_flutter](https://pub.dev/packages/bdk_flutter):** Bitcoin Development Kit para integrar funcionalidades completas de Bitcoin.
* **[bip39](https://pub.dev/packages/bip39) & [bip32](https://pub.dev/packages/bip32):** Generación y manejo de mnemonics y derivación de billeteras HD (Hierarchical Deterministic).

### Redes & Datos
* **[Dio](https://pub.dev/packages/dio) & [Retrofit](https://pub.dev/packages/retrofit):** Clientes HTTP potentes y tipados para llamadas a APIs externas.
* **[Freezed](https://pub.dev/packages/freezed) & [Json Serializable](https://pub.dev/packages/json_serializable):** Clases de datos inmutables y de serialización segura (generación de código).

---

## 🚀 Cómo Empezar

### Requisitos Previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versión 3.11.0 o superior)
- Dart SDK
- Android Studio / Xcode para compilación

### Instalación

1. Clona este repositorio:
   ```bash
   git clone https://github.com/tu-usuario/non_custodial_wallet.git
   cd non_custodial_wallet
   ```

2. Instala las dependencias del proyecto:
   ```bash
   flutter pub get
   ```

3. Genera los archivos necesarios (Freezed, Retrofit, JSON Serializable):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

---

## 📁 Estructura del Proyecto

La estructura de carpetas está orientada por funcionalidades y separación de responsabilidades:

```text
lib/
 ┣ ui/                  # Componentes de la interfaz de usuario
 ┃ ┣ core/              # Configuraciones base (Navegación, DI, Logger, L10n)
 ┃ ┣ features/          # Pantallas y lógicas divididas por módulos
 ┃ ┃ ┣ cubits/          # Manejadores de estado BLoC/Cubit (Market, Wallet) 
 ┃ ...
 ┗ main.dart            # Punto de entrada de la aplicación
```

---

## 🔒 Aviso de Seguridad

Este proyecto es una plantilla de desarrollo y un clon educativo. Si vas a utilizar este código para una billetera de producción:
* Realiza auditorías de seguridad sobre la gestión de claves privadas.
* Asegúrate de manejar correctamente el almacenamiento cifrado nativo.
* No compartas ni expongas frases semilla en logs de consola.

---

¡Construido con ❤️ usando Flutter!
