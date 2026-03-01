# Non-Custodial Wallet

![Flutter Version](https://img.shields.io/badge/Flutter-%5E3.11.0-blue.svg?style=flat&logo=flutter)
![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg?style=flat&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg)

A mobile application built with **Flutter** that serves as a non-custodial cryptocurrency wallet. Users maintain full control of their private keys and seed phrases — no third-party custody involved.

Built with Clean Architecture (Domain / Data / Presentation layers), the project prioritizes security, multi-chain asset management, and a smooth user experience.

---

## App Preview

<table align="center">
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/296af32e-f1b1-436a-a7d0-a1771f825900" width="200" /><br /><sub><b>Welcome</b></sub></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/aa7f496a-1574-4a62-8e60-fac04b7587d1" width="200" /><br /><sub><b>PIN Lock</b></sub></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/05e4c3e5-3f1e-48b0-8f95-9398a306b977" width="200" /><br /><sub><b>Home</b></sub></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/4c15cfcd-ee40-47e4-930f-6ceabfda7828" width="200" /><br /><sub><b>Settings</b></sub></td>
  </tr>
  <tr>
    <td align="center"><img src="https://github.com/user-attachments/assets/f320e187-892a-4bdd-9a29-fc74a7829ef5" width="200" /><br /><sub><b>Tokens</b></sub></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/a13d1d04-f0ea-42cb-b1d6-f7f6d8c665e4" width="200" /><br /><sub><b>Swap</b></sub></td>
    <td align="center"><img src="https://github.com/user-attachments/assets/2362a8c6-9e93-4a30-9951-268f35e6239f" width="200" /><br /><sub><b>Receive</b></sub></td>
    <td></td>
  </tr>
</table>

---

## Features

### Wallet Management
- **Create Wallet** — Generate BIP39 mnemonic phrases (12/24 words) with BIP32 HD key derivation.
- **Import Wallet** — Restore an existing wallet from a seed phrase with full validation.
- **Non-Custodial** — Private keys are stored exclusively on-device using platform-native secure storage (Keychain on iOS, Keystore on Android). Keys are zeroed from memory after use.

### Multi-Chain Support

| Network | Mainnet | Testnet |
|---------|---------|---------|
| Ethereum | Chain 1 | Sepolia (11155111) |
| Optimism | Chain 10 | Sepolia (11155420) |
| Polygon | Chain 137 | Amoy (80002) |
| Arbitrum | Chain 42161 | Sepolia (421614) |
| Base | Chain 8453 | Sepolia (84532) |

Users can switch between Mainnet and Testnet from Settings.

### Send Transactions
- Send native currency (ETH) and ERC-20 tokens across supported networks.
- Real-time gas estimation before submitting.
- PIN verification required to sign every transaction.
- Transaction hash and status tracking after submission.

### Receive
- Display wallet address with QR code generation (EIP-681 compliant).
- Optional amount parameter embedded in QR.
- Copy address and share via system share sheet.

### Token Swap / Exchange
- Select source and destination assets across networks.
- Real-time quote fetching with expiry countdown.
- Quote execution with EIP-7702 Auth or personal_sign signing.
- Swap status tracking via call ID polling.

### ERC-20 Token Support
- Fetch and display ERC-20 token balances across all active networks.
- Pre-configured token list (USDC, USDC.e, DAI, and more).
- Token detail screen with balance in token and USD, contract address, and block explorer link.

### Market Data
- Real-time cryptocurrency prices via Alchemy API.
- Portfolio value in USD on the home screen.
- TTL-based caching to minimize API calls with pull-to-refresh support.

### Security
- **PIN Protection** — 4-6 digit PIN with PBKDF2 hashing (100,000 iterations) and constant-time comparison.
- **Auto-Lock** — App locks when moved to background; PIN required to resume.
- **Failed Attempt Lockout** — Exponential backoff timer after multiple wrong PIN entries.
- **Secure Storage** — Encrypted mnemonic and PIN hash via `flutter_secure_storage`.
- **Memory Safety** — Credentials zeroed out after signing transactions.

### QR Scanner
- Camera-based QR code scanning for recipient addresses.
- Torch toggle support.

### Testnet Faucet
- Direct links to faucets for all supported testnets.
- Auto-copies wallet address for quick funding.

### Settings
- Network mode toggle (Mainnet / Testnet).
- Light / Dark theme toggle.
- Logout with PIN confirmation and secure key deletion.

### Localization
- English and Spanish (ARB-based i18n).

---

## Architecture

```
lib/
├── domain/                  # Business logic (entities, repositories, use cases)
├── data/                    # Data access (datasources, models, mappers, repositories)
└── ui/                      # Presentation
    ├── features/            # Feature screens
    │   ├── auth/            #   Wallet creation & import
    │   ├── home/            #   Dashboard (Assets, Tokens, Activity tabs)
    │   ├── send/            #   Send transactions
    │   ├── receive/         #   Receive address & QR
    │   ├── swap/            #   Token swaps
    │   ├── settings/        #   App settings
    │   ├── pin/             #   PIN management
    │   ├── qr_scanner/      #   QR scanning
    │   ├── faucet/          #   Testnet faucets
    │   ├── token_detail/    #   Token details
    │   ├── splash/          #   App initialization
    │   └── welcome/         #   Onboarding
    ├── commons/             # Shared cubits & widgets
    └── core/                # DI, routing, theme, l10n, constants
```

---

## Tech Stack

| Category | Libraries |
|----------|-----------|
| **State Management** | Flutter BLoC, Freezed, GetIt |
| **Navigation** | GoRouter |
| **Networking** | Dio, Retrofit |
| **Blockchain** | web3dart, bip39, bip32, crypto |
| **Storage** | flutter_secure_storage, SQLite3 |
| **UI** | Google Fonts, qr_flutter, shimmer, flutter_animate |
| **Utilities** | url_launcher, share_plus, mobile_scanner, logger |

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.11.0+
- Dart SDK
- Android Studio / Xcode

### Installation

```bash
git clone https://github.com/your-username/non_custodial_wallet.git
cd non_custodial_wallet
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Security Notice

This project is intended for educational and development purposes. If you plan to use this code in a production wallet:

- Conduct thorough security audits on private key management.
- Ensure encrypted storage is properly configured for each platform.
- Never expose seed phrases in console logs or debug output.

---

Built with Flutter.
