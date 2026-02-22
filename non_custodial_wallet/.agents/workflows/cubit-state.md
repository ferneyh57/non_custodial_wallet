---
description: Ensure all Cubit states use Freezed with single abstract class
---

# Cubit State Guidelines

When creating a new Cubit or modifying an existing one, you **must** use the `freezed` package for state management. This ensures immutability, pattern matching, and comprehensive state handling.

## Rules
1. Every Cubit State must be an abstract class annotated with `@freezed`.
2. Do not use `Equatable` or plain classes for Cubit States.
3. Use a single factory constructor defining properties with defaults using `@Default(...)`.
4. Avoid using union types (e.g. `const factory FeatureNameState.loading()`) unless strictly required. Use properties like `bool isLoading`, `String? errorMessage`.
5. After creating or modifying a state, run the build_runner: `flutter pub run build_runner build --delete-conflicting-outputs`.

## Template

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

// IMPORTANT: Replace feature_name with the actual feature name
part 'feature_name_state.freezed.dart';

@freezed
abstract class FeatureNameState with _$FeatureNameState {
  const factory FeatureNameState({
    @Default(false) bool isLoading,
    String? errorMessage,
    // Add other fields below
  }) = _FeatureNameState;
}
```
