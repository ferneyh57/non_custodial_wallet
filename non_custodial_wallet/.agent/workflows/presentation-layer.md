---
description: Presentation Layer Guidelines and Templates
---

The Presentation layer handles the UI and user interaction. It depends on the Domain layer (UseCases).

### Folder Structure
*   `screens/`: Top-level pages.
*   `widgets/`: Smaller, reusable UI components.
*   `cubits/`: State management using `Cubit` and `Freezed` states.
*   `logic/`: Encapsulated logic objects for Cubit operations.

### Templates

#### 1. State (using Freezed)
Create in `cubits/feature_state.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/feature_entity.dart';

part 'feature_state.freezed.dart';

@freezed
class FeatureState with _$FeatureState {
  const factory FeatureState({
    @Default(false) bool isLoading,
    List<FeatureEntity>? features,
    String? errorMessage,
    @Default(false) bool isInitial,
  }) = _FeatureState;

  factory FeatureState.initial() => const FeatureState(isInitial: true);
}
```

#### 2. Logic Object
Create in `logic/feature_logic.dart`:
```dart
import '../../domain/usecases/get_features_usecase.dart';
import '../../domain/entities/feature_entity.dart';

class FeatureLogic {
  final GetFeaturesUseCase _getFeaturesUseCase;

  FeatureLogic(this._getFeaturesUseCase);

  Future<List<FeatureEntity>> fetchFeatures() async {
    return await _getFeaturesUseCase.execute();
  }
}
```

#### 3. Cubit
Create in `cubits/feature_cubit.dart`:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature_state.dart';
import '../logic/feature_logic.dart';

class FeatureCubit extends Cubit<FeatureState> {
  final FeatureLogic _logic;

  FeatureCubit(this._logic) : super(const FeatureState.initial());

  Future<void> loadFeatures() async {
    emit(const FeatureState.loading());
    try {
      final features = await _logic.fetchFeatures();
      emit(FeatureState.loaded(features));
    } catch (e) {
      emit(FeatureState.error(e.toString()));
    }
  }
}
```

#### 4. Screen
```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/feature_cubit.dart';
import '../cubits/feature_state.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeatureCubit(context.read<FeatureLogic>())..loadFeatures(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Features')),
        body: BlocBuilder<FeatureCubit, FeatureState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.errorMessage != null) {
              return Center(child: Text(state.errorMessage!));
            }
            if (state.features != null) {
              return ListView.builder(
                itemCount: state.features!.length,
                itemBuilder: (context, index) => ListTile(title: Text(state.features![index].name)),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
```

### Best Practices
*   **Encapsulated Logic**: Always create a `Logic` object to handle the implementation details of a Cubit action.
*   **Immutability**: Use `Freezed` for all Bloc/Cubit states.
*   **Logic-free UI**: The UI should only react to states and call Cubit methods.
*   **Dependency Injection**: Provide Logic objects and Cubits using appropriate providers (e.g., `RepositoryProvider`, `BlocProvider`).
