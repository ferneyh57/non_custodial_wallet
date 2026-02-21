---
description: Presentation Layer Guidelines and Templates
---

The Presentation layer handles the UI and user interaction. Each flow (feature) must have its own directory.

### Folder Structure
Each flow should be located in `lib/ui/features/<flow_name>/` and contain:
*   `screens/`: Flow-specific pages.
*   `widgets/`: Flow-specific widgets (replaces private widget functions).
*   `cubits/`: State management using `Cubit` and `Freezed` states.

> [!IMPORTANT]
> **No Private Widget Functions**: Never use private functions (e.g., `_buildHeader()`) that return widgets inside a Screen or Widget class. Instead, extract these into small, focused `StatelessWidget` classes in the `widgets/` folder of the flow.

### Templates

#### 1. State (using Freezed)
Create in `cubits/<flow>_state.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part '<flow>_state.freezed.dart';

@freezed
abstract class <Flow>State with _$<Flow>State {
  const factory <Flow>State({
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _<Flow>State;
}
```

#### 2. Cubit
Create in `cubits/<flow>_cubit.dart`:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wallet_state.dart';

class <Flow>Cubit extends Cubit<<Flow>State> {
  <Flow>Cubit() : super(<Flow>State());
}
```

#### 3. Flow Widgets
Create in `widgets/feature_component.dart`:
```dart
class FeatureComponent extends StatelessWidget {
  const FeatureComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(...);
  }
}
```

### Navigation & Routing
*   **Centralized Routes**: Always use `AppRoutes` static constants for route paths.
*   **Declarative Navigation**: Prefer `context.go(AppRoutes.feature)` for deep linking/navigation or `context.push(AppRoutes.feature)` for pushing to the stack.
*   **External Logic**: Redirections and authorization should be handled in `lib/ui/router.dart` via `redirect` logic whenever possible.

*   **External Logic**: Redirections and authorization should be handled in `lib/ui/router.dart` via `redirect` logic whenever possible.
 
### Localization (i18n)
*   **No Hardcoded Strings**: All user-facing text must be moved to `lib/l10n/app_en.arb` (and other languages like `app_es.arb`).
*   **Usage**: Access localized strings using the `context.l10n` extension.
*   **Generation**: Run `flutter gen-l10n` after adding new keys to ARB files.
*   **Example**:
    ```dart
    // Use the context extension for cleaner access
    return Text(context.l10n.welcomeMessage);
    ```

### Safety & Best Practices
*   **Bang Operator (!)**: > [!CAUTION]
    > **Avoid the Bang Operator (`!`)**: Be extremely careful with forced unwrapping. Only use it when a value is guaranteed to be non-null by contract or logic. Prefer null-coalescing (`??`), null-safe calls (`?.`), or explicit null checks with proper error handling.

*   **Flow-Based Folders**: Group all UI components of a feature/flow in `lib/ui/features/<flow>/`.
*   **Stateless Componentization**: Prefer many small `StatelessWidget` over large `build` methods or helper functions.
*   **Immutability**: Use `Freezed` for all Bloc/Cubit states.
*   **Logic-free UI**: The UI should only react to states and call Cubit methods.
