import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('IconValue Tests', () {
    test('should hold correct values for IconData', () {
      // Arrange
      const iconData = Icons.home;
      const iconName = 'Home Icon';

      // Act
      final iconValue = IconValue<IconData>(iconData, iconName);

      // Assert
      expect(iconValue.value, iconData);
      expect(iconValue.name, iconName);
    });

    test('should hold correct values for String (image path)', () {
      // Arrange
      const imagePath = 'assets/icons/home.png';
      const imageName = 'Home Icon';

      // Act
      final iconValue = IconValue<String>(imagePath, imageName);

      // Assert
      expect(iconValue.value, imagePath);
      expect(iconValue.name, imageName);
    });
    test('should hold correct values for specific Type (image path)', () {
      // Arrange
      final customIcon = CustomIconModel(1, 'Custom Icon Description');
      const iconName = 'Custom Icon';
      // Act
      final iconValue = IconValue<CustomIconModel>(customIcon, iconName);

      // Assert
      expect(iconValue.value, isA<CustomIconModel>());
      expect(iconValue.value.id, customIcon.id);
      expect(iconValue.value.description, customIcon.description);
      expect(iconValue.name, iconName);
    });

    // Add more tests if you extend IconValue with additional properties or methods
  });
}

class CustomIconModel {
  final int id;
  final String description;

  CustomIconModel(this.id, this.description);
}
