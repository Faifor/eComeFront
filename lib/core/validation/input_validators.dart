class InputValidators {
  const InputValidators._();

  static String? validateProfileName(String? value) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty) {
      return 'Name is required';
    }
    if (normalized.length < 2) {
      return 'Name must contain at least 2 characters';
    }
    return null;
  }

  static String? validateQuantity(int value) {
    if (value < 1) {
      return 'Quantity must be at least 1';
    }
    if (value > 999) {
      return 'Quantity must be less than 1000';
    }
    return null;
  }

  static String? validatePromoCode(String? value) {
    final normalized = value?.trim() ?? '';
    if (normalized.isEmpty) {
      return null;
    }
    final promoPattern = RegExp(r'^[A-Z0-9]{4,12}$');
    if (!promoPattern.hasMatch(normalized)) {
      return 'Promo code must be 4-12 chars and use A-Z/0-9';
    }
    return null;
  }

  static String? validateFilters(Map<String, dynamic> filters) {
    if (filters.containsKey('dateFrom') && filters.containsKey('dateTo')) {
      final from = DateTime.tryParse(filters['dateFrom'].toString());
      final to = DateTime.tryParse(filters['dateTo'].toString());
      if (from != null && to != null && from.isAfter(to)) {
        return 'Start date must be before end date';
      }
    }

    final minTotalRaw = filters['minTotal'];
    if (minTotalRaw != null) {
      final minTotal = double.tryParse(minTotalRaw.toString());
      if (minTotal == null || minTotal < 0) {
        return 'Minimum total must be a positive number';
      }
    }

    return null;
  }
}
