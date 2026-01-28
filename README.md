# BeeRace

## Software patterns in use

- MVVM: ViewModels bind to view controllers via `ViewModelBindable` (that lives in the `Protocols` package). Views built in SwiftUI views, with view models served by `ObservableObject`.
- Factory/Provider: factories assemble feature modules and inject dependencies (e.g. `RaceFactory`).
- Repository: domain data access served following the Repository patter (e.g `RaceRepository`), which is backed by `APIClient`.
- Router/Navigation: feature routers handling screen transitions (e.g. `RaceRouter`).
- Dependency Injection (Service Locator): `Locator` registers and resolves shared services.
- Protocol‑oriented modularization: feature and utility modules are split into Swift Packages (`Race`, `APIClient`, `Models`, etc.).
- UIKit + SwiftUI composition: UIKit view controllers host SwiftUI views via `UIHostingController`.

