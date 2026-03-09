import 'package:ecom_front/core/validation/input_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('InputValidators', () {
    test('validates profile', () {
      expect(InputValidators.validateProfileName(''), isNotNull);
      expect(InputValidators.validateProfileName('A'), isNotNull);
      expect(InputValidators.validateProfileName('Alex'), isNull);
    });

    test('validates quantity', () {
      expect(InputValidators.validateQuantity(0), isNotNull);
      expect(InputValidators.validateQuantity(1), isNull);
      expect(InputValidators.validateQuantity(1000), isNotNull);
    });

    test('validates promo code', () {
      expect(InputValidators.validatePromoCode('bad-code'), isNotNull);
      expect(InputValidators.validatePromoCode('SAVE10'), isNull);
    });

    test('validates filters', () {
      expect(
        InputValidators.validateFilters({'dateFrom': '2024-02-01', 'dateTo': '2024-01-01'}),
        isNotNull,
      );
      expect(
        InputValidators.validateFilters({'dateFrom': '2024-01-01', 'dateTo': '2024-02-01', 'minTotal': '10'}),
        isNull,
      );
    });
  });
}
