class PaginationQuery {
  const PaginationQuery({this.page = 1, this.perPage = 20});

  final int page;
  final int perPage;

  Map<String, dynamic> toQuery() => {'page': page, 'per_page': perPage};
}

class FilterQuery {
  const FilterQuery({this.search, this.filters = const {}, this.sortBy, this.sortOrder = 'asc'});

  final String? search;
  final Map<String, dynamic> filters;
  final String? sortBy;
  final String sortOrder;

  Map<String, dynamic> toQuery() {
    return {
      if (search != null && search!.isNotEmpty) 'search': search,
      if (sortBy != null && sortBy!.isNotEmpty) 'sort_by': sortBy,
      'sort_order': sortOrder,
      ...filters,
    };
  }
}

class PageRequest {
  const PageRequest({this.pagination = const PaginationQuery(), this.filter = const FilterQuery()});

  final PaginationQuery pagination;
  final FilterQuery filter;

  Map<String, dynamic> toQuery() => {...pagination.toQuery(), ...filter.toQuery()};
}

class PageResponse<T> {
  const PageResponse({required this.items, required this.page, required this.perPage, required this.total});

  final List<T> items;
  final int page;
  final int perPage;
  final int total;
}
