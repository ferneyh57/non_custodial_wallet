---
description: Create a new feature with 3 layers (Domain, Data, Presentation)
---

This workflow guides you through creating a new feature following the 3-layer architecture (UI/Presentation, Domain, Data) as per Google's recommendations for Clean Architecture in Flutter.

### Steps

1. **Define the Feature Name**
   Identify the name of the feature you want to create (e.g., `send_transaction`, `wallet_import`).

2. **Create the Directory Structure**
   Run the following command to create the basic folder structure:
   ```bash
   mkdir -p lib/features/<feature_name>/domain/entities
   mkdir -p lib/features/<feature_name>/domain/repositories
   mkdir -p lib/features/<feature_name>/domain/usecases
   mkdir -p lib/features/<feature_name>/data/models
   mkdir -p lib/features/<feature_name>/data/repositories
   mkdir -p lib/features/<feature_name>/data/datasources
   mkdir -p lib/ui/features/<feature_name>/screens
   mkdir -p lib/ui/features/<feature_name>/widgets
   mkdir -p lib/ui/features/<feature_name>/cubits
   ```

3. **Implement the Domain Layer**
   Follow the [domain-layer](file:///Users/ferneyhurtado/Dev/non_custodial_wallet/non_custodial_wallet/.agent/workflows/domain-layer.md) workflow to define:
   *   **Entities**: Pure Dart objects representing the business logic.
   *   **Repository Interfaces**: Abstract classes defining the contract for data operations.
   *   **UseCases**: Single-responsibility classes that execute specific business logic.

4. **Implement the Data Layer**
   Follow the [data-layer](file:///Users/ferneyhurtado/Dev/non_custodial_wallet/non_custodial_wallet/.agent/workflows/data-layer.md) workflow to define:
   *   **Models (DTOs)**: Objects for data transfer, including `fromJson` and `toJson` methods.
   *   **DataSources**: Classes responsible for fetching data from specific sources (API, local DB).
   *   **Repository Implementations**: Implementation of the domain repository interfaces.

5. **Implement the Presentation Layer**
   Follow the [presentation-layer](file:///Users/ferneyhurtado/Dev/non_custodial_wallet/non_custodial_wallet/.agent/workflows/presentation-layer.md) workflow to define:
   *   **Screens**: Complete UI pages.
   *   **Widgets**: Reusable UI components.
   *   **Cubits**: State management using BLoC pattern.
   *   **Logic**: Encapsulated logic objects for Cubits.
   *   **States**: Immutable states using `Freezed`.

6. **Register Dependencies**
   Ensure all new classes are properly registered in `lib/injection_container.dart`.

7. **Register Routing**
   If the feature has its own screen:
   *   Add a static constant to `lib/ui/app_routes.dart`.
   *   Register the route in `lib/ui/router.dart`.

8. **Add Localization**
    *   Add any new user-facing strings to `lib/l10n/app_en.arb` and `lib/l10n/app_es.arb`.
    *   Run `flutter gen-l10n` to update the generated classes.
    *   Use the `context.l10n` extension in your screens/widgets.
    *   **Rule**: Avoid using the `!` (bang) operator unless absolutely necessary.
