# CLAUDE.md - Non-Custodial Wallet

## Project Overview
Flutter non-custodial cryptocurrency wallet (ETH) using Clean Architecture (3 layers).
- **SDK**: Dart ^3.11.0 / Flutter
- **Platforms**: iOS, Android, macOS, Web

## Architecture (Clean Architecture - 3 Layers)

### Domain Layer (`lib/domain/`)
- `entities/` — Pure Dart business objects (no Flutter imports)
- `repositories/` — Abstract interfaces (contracts)
- `usecases/` — Single-responsibility business logic classes with `execute()` method
- **Rules**: No framework imports. Use `final` fields, `const` constructors. One UseCase = one action.

### Data Layer (`lib/data/`)
- `models/` — DTOs with `fromJson`/`toJson` (can use `@JsonSerializable` or `@freezed`)
- `datasources/` — API, local storage, blockchain data access
- `repositories/` — Implement domain repository interfaces
- `mappers/` — Entity <-> Model conversion (when conversion logic is complex)
- **Rules**: Convert external exceptions into domain `Failure` types. Keep DataSource focused on raw data.

### Presentation Layer (`lib/ui/`)
- `features/screens/<feature>/` — Full-page widgets
- `features/cubits/<feature>/` — Cubits + Freezed states
- `features/widgets/<feature>/` — Reusable UI components
- `core/` — DI, routing, l10n, extensions, constants, error types

## Key Conventions

### State Management (Cubit + Freezed)
- All states **must** use `@freezed` abstract class with single factory constructor
- Use `@Default(...)` for default values, properties like `bool isLoading`, `String? errorMessage`
- **Do NOT use union types** (e.g., `State.loading()`) unless strictly required
- **Do NOT use Equatable** — Freezed handles equality
- After modifying states: `make build`

### Widget Rules
- **No private widget functions** (e.g., `_buildHeader()`). Extract to `StatelessWidget` in `widgets/`
- Prefer many small `StatelessWidget` over large `build` methods
- UI must be logic-free: only react to states and call Cubit methods

### Null Safety
- **Avoid the `!` bang operator** unless value is guaranteed non-null by contract
- Prefer `??`, `?.`, or explicit null checks

### Localization (i18n)
- ARB files: `lib/ui/core/l10n/app_en.arb`, `app_es.arb`
- Access via `context.l10n.keyName`
- All user-facing strings must be localized (no hardcoded strings)
- After adding keys: `make l10n`

### Dependency Injection
- Service locator: `GetIt` in `lib/ui/core/di.dart`
- Registration order: DataSources -> Repositories -> UseCases -> Cubits
- Use lazy singletons for repos/usecases, factories for cubits

### Routing
- Routes defined as static constants in `lib/ui/core/routes/app_routes.dart`
- Router config in `lib/ui/core/routes/router.dart`
- Use `context.go()` for navigation, `context.push()` for stack push
- Auth redirects handled in router's `redirect` logic

### Error Handling
- `Result<T>` type for success/failure (`lib/ui/core/util/`)
- `Failure` subtypes: `ServerFailure`, `CacheFailure`, `ValidationFailure`, `SecureStorageFailure`

## Creating a New Feature
1. Create folder structure in domain, data, and ui layers under `<feature_name>/`
2. Implement Domain: entities -> repository interface -> use cases
3. Implement Data: models -> datasources -> repository implementation
4. Implement Presentation: state (freezed) -> cubit -> widgets -> screen
5. Register in DI (`lib/ui/core/di.dart`)
6. Add route (`app_routes.dart` + `router.dart`)
7. Add localized strings to ARB files, run `make l10n`
8. Run `make build` to generate freezed/json/retrofit code

## Common Commands (Makefile)
```
make get        # flutter pub get
make build      # build_runner (generate freezed, json, retrofit)
make l10n       # generate localization
make analyze    # flutter analyze
make format     # dart format .
make test       # flutter test
make clean      # flutter clean
```

## Key Dependencies
- `flutter_bloc` / `freezed` — State management
- `get_it` — DI
- `go_router` — Navigation
- `dio` / `retrofit` — HTTP/API
- `bip39` / `bip32` / `web3dart` — Crypto/Blockchain (Ethereum)
- `flutter_secure_storage` — Secure key storage
- `qr_flutter` / `share_plus` — QR codes and sharing
