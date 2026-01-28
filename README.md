# BeeRace

## Software patterns in use

- MVVM: ViewModels bind to view controllers via `ViewModelBindable`, with SwiftUI views driven by `ObservableObject` state.
- Repository: domain data access behind `RaceRepository`, backed by `APIClient`.
- Router/Navigation: feature routers handle screen transitions (e.g. `RaceRouter`).
- Factory/Provider: factories assemble feature modules and inject dependencies (e.g. `RaceFactory`).
- Dependency Injection (Service Locator): `Locator` registers and resolves shared services.
- Protocol‑oriented modularization: feature and utility modules are split into Swift Packages (`Race`, `APIClient`, `Models`, etc.).
- UIKit + SwiftUI composition: UIKit view controllers host SwiftUI views via `UIHostingController`.

