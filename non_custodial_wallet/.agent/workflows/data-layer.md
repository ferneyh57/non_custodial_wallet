---
description: Data Layer Guidelines and Templates
---

The Data layer is responsible for retrieving and storing data. It implements the interfaces defined in the Domain layer.

### Folder Structure
*   `models/`: Data Transfer Objects (DTOs), includes serialization.
*   `datasources/`: Concrete implementations of data retrieval (API, Database).
*   `repositories/`: Implementation of Domain repository interfaces.

### Templates

#### 1. Model (DTO)
```dart
import '../../domain/entities/feature_entity.dart';

class FeatureModel extends FeatureEntity {
  const FeatureModel({
    required super.id,
    required super.name,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
```

#### 2. DataSource Interface & Implementation
```dart
abstract class FeatureRemoteDataSource {
  Future<List<FeatureModel>> getFeaturesFromApi();
}

class FeatureRemoteDataSourceImpl implements FeatureRemoteDataSource {
  @override
  Future<List<FeatureModel>> getFeaturesFromApi() async {
    // Implementation with http, dio, etc.
    return [];
  }
}
```

#### 3. Repository Implementation
```dart
import '../../domain/repositories/feature_repository.dart';
import '../datasources/feature_remote_datasource.dart';
import '../models/feature_model.dart';

class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureRemoteDataSource remoteDataSource;

  FeatureRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<FeatureModel>> getFeatures() async {
    return await remoteDataSource.getFeaturesFromApi();
  }

  @override
  Future<void> saveFeature(covariant FeatureModel feature) async {
    // Handle saving
  }
}
```

### Best Practices
*   **Separation of Concerns**: Keep DataSource focused on raw data and Repository focused on coordinate data sources.
*   **Error Handling**: Convert external exceptions (SocketException, HttpException) into custom domain-specific failures.
*   **Mappers**: (Optional) Use explicit mapper classes if the conversion logic between Model and Entity is complex.
