---
description: Presentation Layer Guidelines and Templates
---

The Presentation layer handles the UI and user interaction. It depends on the Domain layer (UseCases).

### Folder Structure
*   `screens/`: Top-level pages.
*   `widgets/`: Smaller, reusable UI components.
*   `providers/`: State management using the `Provider` package.

### Templates

#### 1. Provider (State Management)
```dart
import 'package:flutter/material.dart';
import '../../domain/usecases/get_features_usecase.dart';
import '../../domain/entities/feature_entity.dart';

class FeatureProvider extends ChangeNotifier {
  final GetFeaturesUseCase getFeaturesUseCase;

  List<FeatureEntity> _features = [];
  bool _isLoading = false;

  FeatureProvider({required this.getFeaturesUseCase});

  List<FeatureEntity> get features => _features;
  bool get isLoading => _isLoading;

  Future<void> loadFeatures() async {
    _isLoading = true;
    notifyListeners();

    try {
      _features = await getFeaturesUseCase.execute();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

#### 2. Screen
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/feature_provider.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Features')),
      body: Consumer<FeatureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: provider.features.length,
            itemBuilder: (context, index) {
              final feature = provider.features[index];
              return ListTile(title: Text(feature.name));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<FeatureProvider>().loadFeatures(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

### Best Practices
*   **Logic-free UI**: Keep logic in the Provider and only use the UI for display.
*   **Reusable Widgets**: Extract complex UI parts into the `widgets/` folder.
*   **Provider Scope**: Ensure the Provider is available in the widget tree (usually via `ChangeNotifierProvider`).
