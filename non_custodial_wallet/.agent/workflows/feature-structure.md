---
description: Feature Folder Structure Guidelines
---

To maintain a clean and scalable codebase, all features must be organized into dedicated folders within each architectural layer. This prevents layers from becoming cluttered with unrelated files.

### 1. Structure Rules

#### Domain Layer
- **Repositories**: `lib/domain/repositories/<feature_name>/`
- **Use Cases**: `lib/domain/usecases/<feature_name>/`
- **Entities**: `lib/domain/entities/<feature_name>/` (if applicable)

#### Data Layer
- **Repositories**: `lib/data/repositories/` (Implementations usually go here directly if there's only one, or in `<feature_name>/` if complex)
- **DataSources**: `lib/data/datasources/`
- **Models**: `lib/data/models/<feature_name>/`

#### UI / Presentation Layer
- **Screens**: `lib/ui/features/screens/<feature_name>/`
- **Cubits**: `lib/ui/features/cubits/<feature_name>/`
- **Widgets**: `lib/ui/features/widgets/<feature_name>/` (if specific to the feature)

### 2. Benefits
- **Searchability**: Files related to the same logic are grouped together.
- **Independence**: Changes to one feature folder are less likely to conflict with others.
- **Scalability**: Easier to add new features without increasing complexity in root directories.

### 3. Example Folder Layout
```text
lib/
├── domain/
│   ├── repositories/
│   │   └── wallet/
│   │       └── wallet_repository.dart
│   └── usecases/
│       └── wallet/
│           ├── create_wallet_use_case.dart
│           └── get_balance_use_case.dart
├── ui/
│   └── features/
│       ├── screens/
│       │   └── wallet/
│       │       └── wallet_screen.dart
│       └── cubits/
│           └── wallet/
│               ├── wallet_cubit.dart
│               └── wallet_state.dart
```
