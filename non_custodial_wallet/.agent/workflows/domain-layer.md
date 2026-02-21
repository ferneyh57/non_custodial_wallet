---
description: Domain Layer Guidelines and Templates
---

The Domain layer is the heart of the application. It contains the business logic and is completely independent of other layers and external libraries.

### Folder Structure
*   `entities/`: Pure Dart objects.
*   `repositories/`: Abstract class contracts.
*   `usecases/`: Application-specific business rules.

### Templates

#### 1. Entity
```dart
class FeatureEntity {
  final String id;
  final String name;

  const FeatureEntity({
    required this.id,
    required this.name,
  });
}
```

#### 2. Repository Interface
```dart
import '../entities/feature_entity.dart';

abstract class FeatureRepository {
  Future<List<FeatureEntity>> getFeatures();
  Future<void> saveFeature(FeatureEntity feature);
}
```

#### 3. UseCase
```dart
import '../entities/feature_entity.dart';
import '../repositories/feature_repository.dart';

class GetFeaturesUseCase {
  final FeatureRepository repository;

  GetFeaturesUseCase(this.repository);

  Future<List<FeatureEntity>> execute() async {
    return await repository.getFeatures();
  }
}
```

### Best Practices
*   **No Framework imports**: Avoid importing `material.dart` or any data layer classes.
*   **Immutability**: Use `final` fields and `const` constructors where possible.
*   **Single Responsibility**: Each UseCase should do one thing only.
