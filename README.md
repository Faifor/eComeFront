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

## Prerequisites

- Flutter SDK (stable channel).
- Dart SDK (входит в Flutter SDK).
- Browser toolchain для web (`flutter config --enable-web` при необходимости).
- Доступ к backend окружениям (dev/stage/prod) и валидные токены для защищённых сценариев.

## Запуск приложения (dev / stage / prod)

Конфигурация окружения загружается из compile-time переменных в `EnvConfig.load()`:

- `APP_ENV` — `dev | stage | prod`.
- `API_BASE_URL` — базовый URL backend.

Примеры запуска:

```bash
# dev
flutter run -d chrome \
  --dart-define=APP_ENV=dev \
  --dart-define=API_BASE_URL=https://dev-api.example.com/api/v1

# stage
flutter run -d chrome \
  --dart-define=APP_ENV=stage \
  --dart-define=API_BASE_URL=https://stage-api.example.com/api/v1

# prod
flutter run -d chrome \
  --dart-define=APP_ENV=prod \
  --dart-define=API_BASE_URL=https://api.example.com/api/v1
```

> Если в вашей инфраструктуре переменная называется `BACKEND_BASE_URL`, прокиньте её в `API_BASE_URL` на этапе запуска/CI (например, через shell-export или секреты pipeline).

## Web build / deploy

Сборка web:

```bash
flutter pub get
flutter build web \
  --release \
  --dart-define=APP_ENV=prod \
  --dart-define=API_BASE_URL=https://api.example.com/api/v1
```

Артефакты будут в `build/web`.

Базовый процесс деплоя:

1. Выполнить `flutter build web ...` с нужным окружением.
2. Опубликовать содержимое `build/web` в статический хостинг (Nginx, S3+CloudFront, Firebase Hosting, etc.).
3. Настроить fallback для SPA-роутов на `index.html`.
4. Проверить, что backend разрешает CORS для origin вашего frontend-домена.

## Где настраивается `BACKEND_BASE_URL` и `/api/v1`

- В коде приложение читает именно `API_BASE_URL` в `lib/core/config/env_config.dart`.
- `BACKEND_BASE_URL` можно использовать как внешнее имя переменной в CI/CD, но перед запуском Flutter её нужно маппить в `API_BASE_URL`.
- Префикс `/api/v1` централизованно задаётся в значении `API_BASE_URL` (например, `https://host/api/v1`), а feature-API используют относительные пути (`/catalog`, `/orders`, `/auth/refresh` и т.д.).

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

### Как добавить новый endpoint через шаблон (DTO -> repo -> use case -> UI -> route -> test)

1. **DTO**: описать request/response модели в `data/models/*` или `data/*_dto.dart`.
2. **Repository (data layer)**: добавить вызов endpoint в `<feature>_api.dart` и маппинг DTO -> Entity в `<feature>_repository_impl.dart`.
3. **Use case (domain layer)**: расширить контракт `domain/<feature>_repository.dart` и создать/обновить use case (`get_<feature>_items_use_case.dart` или отдельный сценарий).
4. **UI (presentation layer)**: подключить новый use case в controller/provider и отобразить состояние на экране.
5. **Route**: зарегистрировать маршрут в `lib/core/routing/routes.dart` и подключить экран в `lib/core/routing/app_router.dart`.
6. **Test**:
   - unit-тесты use case/repository;
   - тесты маппинга DTO;
   - widget/integration-тест экрана (happy path + ошибки 401/429/5xx).

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

## Security

- **Хранение токенов**:
  - текущий `TokenStorage` — in-memory storage (токены очищаются при перезапуске вкладки/приложения);
  - для web fallback в `localStorage/sessionStorage` повышает риск кражи токена при XSS, поэтому используйте только как осознанный компромисс и минимизируйте TTL токенов.
- **XSS mitigation**:
  - не рендерить недоверенный HTML/JS;
  - валидировать и экранировать пользовательские данные;
  - держать зависимости Flutter/web-plugins в актуальных версиях.
- **CSP (Content Security Policy)**:
  - на уровне web-сервера задавать строгий CSP (ограничение `script-src`, `connect-src`, запрет inline-скриптов, где возможно);
  - явно разрешать только доверенные backend-origin для API.
- **Token rotation**:
  - клиент уже использует refresh flow (`POST /auth/refresh`) и переоткрывает сессию при успешном ответе;
  - при ошибке refresh сессия очищается и пользователь переводится в неавторизованное состояние.

## Troubleshooting

### 401 / refresh loop

Симптомы:
- Частые `401`, пользователь выбрасывается на login.

Проверить:
1. `API_BASE_URL` указывает на верный backend и верную версию API.
2. В refresh-ответе приходит непустой `accessToken`.
3. `POST /auth/refresh` доступен без `Authorization` header и принимает `refreshToken`.
4. Повторяются только idempotent/safe-запросы (или отмеченные idempotent флагом).

### CORS

Симптомы:
- Web-клиент получает network/CORS ошибки до уровня бизнес-логики.

Проверить:
1. Backend возвращает `Access-Control-Allow-Origin` для frontend origin.
2. Разрешены необходимые методы/headers (`Authorization`, `Content-Type`, `X-Request-ID`).
3. Preflight `OPTIONS` запросы обрабатываются корректно.

### Rate-limit (429)

Симптомы:
- Сервер часто отвечает `429 Too Many Requests`.

Проверить:
1. Учитывается `Retry-After` (если есть).
2. На UI есть backoff/дебаунс и блокировка повторных submit.
3. Не происходит циклических рефетчей из-за состояния экрана.

### Network errors / timeout

Симптомы:
- Ошибки сети, таймауты, нестабильные ответы.

Проверить:
1. Доступность backend (DNS/TLS/firewall/VPN).
2. Корректность `API_BASE_URL` и сертификатов.
3. Наличие graceful fallback в UI (retry-кнопка, сохранение предыдущего snapshot для list-экранов).

## Testing

- Локально: `flutter test --reporter expanded`
- CI: workflow `.github/workflows/ci.yml` запускает `flutter pub get` и `flutter test --reporter expanded`.
- Тестовые данные и doubles:
  - JSON fixtures: `test/fixtures/*.json`
  - Mock repositories/API doubles: `test/doubles/mock_repositories.dart`
