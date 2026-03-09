# eComeFront

Flutter-приложение с feature-first архитектурой, где каждый endpoint добавляется в новую/существующую feature без изменений в `core`.

## Документация по интеграции

- [API integration matrix](docs/api-integration.md)
- [Sequence diagrams (text)](docs/sequences.md)

## Архитектура

```text
lib/
  core/
    auth/
    bootstrap/
    config/
    error/
    network/
    routing/
    utils/
  shared/
    constants/
    extensions/
    ui-kit/
    widgets/
  features/
    auth|catalog|pricing|cart|orders|admin|reports/
      data/
      domain/
      presentation/
```

## Bootstrap (`lib/main.dart`)

`main.dart` содержит только:
1. Инициализацию env-конфига.
2. Подготовку DI/провайдеров.
3. Подключение роутера.

## Шаблон генерации новой feature

Ниже базовый шаблон для добавления новой feature `<feature>` с новым endpoint:

```text
lib/features/<feature>/
  data/
    <feature>_api.dart
    <feature>_repository_impl.dart
    <feature>_dto.dart
  domain/
    <feature>_entity.dart
    <feature>_repository.dart
    get_<feature>_items_use_case.dart
  presentation/
    <feature>_screen.dart
    <feature>_controller.dart  # StateNotifier/AsyncNotifier
    <feature>_widgets.dart
```

### Контракт по слоям

- `data/<feature>_api.dart` — вызовы endpoint и парсинг DTO.
- `data/<feature>_repository_impl.dart` — маппинг DTO -> entity и реализация domain-контрактов.
- `domain/<feature>_repository.dart` — интерфейс репозитория.
- `domain/get_<feature>_items_use_case.dart` — бизнес-сценарий.
- `presentation/*` — экран, state/controller/provider, UI-виджеты.

## Пример модуля: `reports`

- API: `lib/features/reports/data/reports_api.dart`
- Repository impl: `lib/features/reports/data/reports_repository_impl.dart`
- Domain contract: `lib/features/reports/domain/reports_repository.dart`
- Use case: `lib/features/reports/domain/get_reports_items_use_case.dart`
- Presentation: `lib/features/reports/presentation/reports_screen.dart`

> Новый endpoint добавляется в соответствующую feature через `data -> domain -> presentation`, не требуя изменений в `lib/core/*`.

## Riverpod DI и нейминг провайдеров

- Все провайдеры размещаются в `lib/core/di/providers.dart`.
- Именование провайдеров фиксируется суффиксом `Provider`:
  - инфраструктура: `<service>Provider` (`dioProvider`, `apiClientProvider`, `tokenStorageProvider`, `authSessionProvider`);
  - data/domain: `<feature>ApiProvider`, `<feature>RepositoryProvider`, `get<Feature>ItemsUseCaseProvider`;
  - экранные состояния: `<feature>StateProvider` (через `StateNotifierProvider`/`AsyncNotifierProvider`).
- Для одного типа зависимости используем один источник истины (single provider per dependency type).


## Testing

- Локально: `flutter test --reporter expanded`
- CI: workflow `.github/workflows/ci.yml` запускает `flutter pub get` и `flutter test --reporter expanded`.
- Тестовые данные и doubles:
  - JSON fixtures: `test/fixtures/*.json`
  - Mock repositories/API doubles: `test/doubles/mock_repositories.dart`
