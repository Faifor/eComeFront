# Текстовые sequence-диаграммы

## 1) Login + refresh flow

```text
Actors: User, AuthScreen, AuthController, ApiClient/Dio, Backend, AuthSession

User -> AuthScreen: вводит email/password, нажимает Login
AuthScreen -> AuthController: submit(credentials)
AuthController -> ApiClient/Dio: POST /auth/login   (ASSUMPTION)
ApiClient/Dio -> Backend: POST /auth/login
Backend --> ApiClient/Dio: 200 {accessToken, refreshToken, user}
ApiClient/Dio -> AuthSession: open(accessToken, refreshToken)
AuthController --> AuthScreen: success -> navigate to app shell

... позже любой защищённый запрос ...

AuthController -> ApiClient/Dio: GET /catalog (пример)
ApiClient/Dio -> Backend: GET /catalog + Authorization: Bearer <expired>
Backend --> ApiClient/Dio: 401 Unauthorized
ApiClient/Dio (RefreshTokenInterceptor) -> Backend: POST /auth/refresh {refreshToken}
Backend --> ApiClient/Dio: 200 {accessToken(new), refreshToken?}
ApiClient/Dio -> AuthSession: update tokens
ApiClient/Dio -> Backend: replay original GET /catalog
Backend --> ApiClient/Dio: 200 data
AuthController --> AuthScreen: render data

Failure branch:
Backend --> ApiClient/Dio: 401/4xx/5xx on /auth/refresh
ApiClient/Dio -> AuthSession: clear()
ApiClient/Dio --> AuthController: propagate Unauthorized
AuthController --> AuthScreen: logout + redirect to Auth
```

Safe fallback:
- Если refresh неуспешен — без бесконечных повторов, только logout.
- Если `/auth/login` вернул неизвестный формат — показать общее сообщение об ошибке, не открывать сессию.

## 2) Cart -> checkout

```text
Actors: User, CartScreen, CartController, ApiClient/Dio, Backend, OrdersScreen

User -> CartScreen: открывает корзину
CartScreen -> CartController: load()
CartController -> ApiClient/Dio: GET /cart
ApiClient/Dio -> Backend: GET /cart
Backend --> ApiClient/Dio: 200 cart items
CartController --> CartScreen: render cart

User -> CartScreen: нажимает Checkout
CartScreen -> CartController: checkout(cartId, addressId, paymentId)
CartController -> ApiClient/Dio: POST /checkout   (ASSUMPTION, idempotent by clientRequestId)
ApiClient/Dio -> Backend: POST /checkout

alt success-sync
  Backend --> ApiClient/Dio: 200 {orderId, status=confirmed}
  CartController --> OrdersScreen: navigate/order highlight
else success-async
  Backend --> ApiClient/Dio: 202 {orderId, status=pending}
  CartController --> OrdersScreen: navigate with "processing" badge
else 5xx/timeout
  Backend --> ApiClient/Dio: error/timeout
  CartController --> CartScreen: show "Статус неизвестен, проверьте Orders"
  CartController -> ApiClient/Dio: optional GET /orders refresh
end
```

Safe fallback:
- Пока идёт checkout, CTA-кнопка заблокирована.
- Повторный submit — только с тем же `clientRequestId`, чтобы избежать дублей.
- При неопределённом результате (`5xx/timeout`) UI не создаёт второй checkout автоматически.

## 3) Admin import (dry-run -> apply)

```text
Actors: Admin, AdminScreen, AdminController, ApiClient/Dio, Backend

Admin -> AdminScreen: выбирает файл импорта
AdminScreen -> AdminController: startDryRun(file)
AdminController -> ApiClient/Dio: POST /admin/import/dry-run   (ASSUMPTION)
ApiClient/Dio -> Backend: dry-run payload
Backend --> ApiClient/Dio: 200 {dryRunId, summary, issues[]}
AdminController --> AdminScreen: показывает summary + ошибки по строкам

Admin -> AdminScreen: подтверждает применение
AdminScreen -> AdminController: apply(dryRunId)
AdminController -> ApiClient/Dio: POST /admin/import/apply   (ASSUMPTION)
ApiClient/Dio -> Backend: {dryRunId, confirm=true}

alt applied
  Backend --> ApiClient/Dio: 200 {importId, status=applied, appliedCount}
  AdminController --> AdminScreen: success state + журнал операции
else processing
  Backend --> ApiClient/Dio: 202 {importId, status=processing}
  AdminController --> AdminScreen: info "Импорт в обработке"
else dryRun expired/not found
  Backend --> ApiClient/Dio: 400/404
  AdminController --> AdminScreen: prompt "Повторите dry-run"
else 5xx
  Backend --> ApiClient/Dio: error
  AdminController --> AdminScreen: "Статус неизвестен, проверьте позже"
end
```

Safe fallback:
- Нельзя вызвать `apply` без валидного `dryRunId`.
- Повторный `apply` по тому же `dryRunId` трактуется как идемпотентный сценарий; UI показывает последний известный статус, не дублирует действие.
- При больших файлах UI показывает прогресс и блокирует повторный upload.
