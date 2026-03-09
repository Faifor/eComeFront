# API Integration Contract (UI ↔ Backend)

Документ фиксирует текущие интеграции клиента, а также **явные предположения** по backend-контрактам, которых пока нет в коде, но они нужны для целевых сценариев (`login`, `checkout`, `admin import`).

## Глобальные правила клиента

- Базовый URL берётся из `EnvConfig.apiBaseUrl`, таймауты: `connect=15s`, `receive=30s`.
- Каждый запрос получает `X-Request-ID` (через `RequestIdInterceptor`).
- При наличии `accessToken` автоматически добавляется `Authorization: Bearer <token>`.
- Для `401` работает авто-refresh через `POST /auth/refresh` с последующим повтором idempotent-запросов.
- Ошибки маппятся в `AppError` типы (`UnauthorizedError`, `ServerError`, `TimeoutError`, ...).

## Endpoint matrix

> Статус:
> - `Implemented` — endpoint реально вызывается в коде.
> - `Assumption` — endpoint не реализован в текущем клиенте; контракт описан как предположение для безопасной интеграции.

| Status | Method + URL | Экран/роль-инициатор | Headers / Query / Body | Response schema (ожидается UI) | Ошибки и UI-реакция | Edge cases |
|---|---|---|---|---|---|---|
| Implemented | `GET /auth` | `AuthScreen`, пользователь | `Authorization` (если есть сессия), `X-Request-ID`; query/body отсутствуют | `200: AuthDto[]` (пока заглушка: клиент возвращает `[]`) | `400`: показать `Snackbar` «Некорректный запрос» + retry-кнопка; `401`: попытка refresh, при провале — logout + редирект на Auth; `403`: экран «Нет доступа»; `404`: пустой state с CTA «Обновить»; `429`: backoff + сообщение «Слишком много запросов»; `5xx`: error state + retry | Пустой массив = «Нет данных». Невалидный payload = fail-safe: лог + показать общий error state без падения |
| Implemented | `POST /auth/refresh` | `RefreshTokenInterceptor` (системный фон) | `Authorization: null` (явно очищается), `X-Request-ID`; body: `{ "refreshToken": "string" }` | `200: { accessToken: string, refreshToken?: string }` | Любая ошибка refresh ⇒ очистка сессии, сброс токенов, возврат пользователя на Auth | Если `refreshToken` отсутствует/пустой — refresh не делается, сессия сразу истекает |
| Assumption | `POST /auth/login` | `AuthScreen`, гость/пользователь | `X-Request-ID`; body: `{ email: string, password: string }` | `200: { accessToken: string, refreshToken: string, user: { id, role } }` | `400`: ошибки валидации полей inline; `401`: «Неверный логин/пароль»; `403`: «Аккаунт заблокирован»; `404`: безопасно как `401` (не раскрывать наличие пользователя); `429`: таймер блокировки кнопки login; `5xx`: retry + fallback «Попробуйте позже» | Если `role` неизвестна — fallback на минимальный user shell (без admin-разделов) |
| Implemented | `GET /catalog` | `CatalogScreen`, пользователь | `Authorization`, `X-Request-ID`; без body | `200: CatalogDto[]` (пока возвращается `[]`) | 400/401/403/404/429/5xx — обработка как в глобальном правиле + безопасный empty/error state | Частично битые элементы списка: фильтровать некорректные items и рендерить остальные |
| Implemented | `GET /pricing` | `PricingScreen`, менеджер/пользователь | `Authorization`, `X-Request-ID`; без body | `200: PricingDto[]` (пока возвращается `[]`) | Аналогично `GET /catalog` | Для отсутствующих цен — показывать `N/A`, не крашить экран |
| Implemented | `GET /cart` | `CartScreen`, пользователь | `Authorization`, `X-Request-ID`; без body | `200: CartDto[]` (пока возвращается `[]`) | Аналогично `GET /catalog` | Если товар недоступен/удалён — пометить строку как invalid и предложить удалить из корзины |
| Assumption | `POST /checkout` | `CartScreen`, пользователь | `Authorization`, `X-Request-ID`; body: `{ cartId: string, deliveryAddressId: string, paymentMethodId: string, clientRequestId: string }` | `202: { orderId: string, status: "pending"|"confirmed" }` или `200` синхронно | `400`: подсветка неверных полей checkout; `401`: refresh/logout; `403`: запрет на оформление; `404`: корзина/адрес не найдены → обновить корзину; `429`: disable CTA + экспоненциальный retry; `5xx`: показать «Заказ может быть создан, проверьте Orders» (idempotency-safe) | Повторное нажатие checkout: использовать `clientRequestId`, кнопку блокировать до ответа |
| Implemented | `GET /orders` | `OrdersScreen`, пользователь/менеджер | `Authorization`, `X-Request-ID`; без body | `200: OrdersDto[]` (пока возвращается `[]`) | Аналогично `GET /catalog` | `pending` заказы должны отображаться даже без totals (fallback: «пересчитывается») |
| Implemented | `GET /reports` | `ReportsScreen`, аналитик/админ | `Authorization`, `X-Request-ID`; query (предположительно) `from,to,groupBy` | `200: ReportsDto[]` (пока возвращается `[]`) | Аналогично `GET /catalog`; `403` — показать заглушку «Недостаточно прав для отчётов» | Если query не поддержана backend, fallback: перезапрос без фильтров |
| Implemented | `GET /admin` | `AdminScreen`, администратор | `Authorization`, `X-Request-ID`; без body | `200: AdminDto[]` (пока возвращается `[]`) | Аналогично `GET /catalog`; `403` — перенаправление на безопасный non-admin home | Если backend вернул расширенные поля — игнорировать неизвестные |
| Assumption | `POST /admin/import/dry-run` | `AdminScreen`, администратор | `Authorization`, `X-Request-ID`; body: `{ source: "csv"|"xlsx", payload: string(base64), options?: {...} }` | `200: { dryRunId: string, summary: { total, valid, invalid }, issues: [{ row, code, message }] }` | `400`: показать список ошибок файла; `401`: refresh/logout; `403`: запрет экрана; `404`: endpoint/version mismatch → предложить обновить клиент; `429`: очередь/повтор позже; `5xx`: сохранить локальную копию файла и предложить повтор | Большой файл: UI должен показывать progress + запрет повторной отправки |
| Assumption | `POST /admin/import/apply` | `AdminScreen`, администратор | `Authorization`, `X-Request-ID`; body: `{ dryRunId: string, confirm: true }` | `200/202: { importId: string, status: "applied"|"processing", appliedCount?: number }` | `400`: dryRunId истёк → предложить повторить dry-run; `401/403`: стандартно; `404`: dryRun не найден; `429`: отложенный retry; `5xx`: показать «Статус неизвестен, проверьте позже» | Повторный apply по тому же `dryRunId` должен быть idempotent; UI не должен дублировать импорт |

## Неописанные backend-контракты: явные предположения

1. `POST /auth/login`, `POST /checkout`, `POST /admin/import/dry-run`, `POST /admin/import/apply` отсутствуют в текущем коде и описаны как **Assumption**.
2. Для `429` предполагается, что backend может отдавать `Retry-After`; если его нет, UI использует экспоненциальный backoff (1s/2s/4s, максимум 3 попытки).
3. Для `5xx` на mutating-операциях (`checkout`, `import/apply`) UI считает результат **неопределённым** и предлагает проверить итоговое состояние через `Orders` / `Import status`, чтобы избежать дублей.
4. Для всех неизвестных полей в ответе используется tolerant parsing (игнорирование лишних полей).

## Safe fallback-поведение UI (обязательное)

- Любой неожиданный формат ответа: не падать, логировать техническую ошибку, показывать user-friendly сообщение и кнопку `Повторить`.
- Для экранов-списков (`catalog/cart/orders/...`) при ошибке — сохранять последний успешно загруженный snapshot (если есть), а не очищать UI до пустого состояния.
- Для критичных POST-операций — блокировка повторного клика до завершения + client-side idempotency key.
- При `401` после неуспешного refresh — немедленный logout, очистка локальной сессии и переход на Auth.
