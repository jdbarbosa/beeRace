//
//  StartProvider.swift
//  Start
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator
import UIKit

public protocol StartProvider {

    @MainActor func startViewController() -> UIViewController?
}

public struct StartProviderImpl: StartProvider {

    private weak var locator: Locator?
    private let factory: StartFactory

    public init(locator: Locator) {
        self.locator = locator
        self.factory = StartFactoryImpl(
            raceProvider: locator.resolve(.raceProvider)
        )
    }

    @MainActor public func startViewController() -> UIViewController? {
        guard let locator = locator else {
            fatalError("Locator is not set")
        }
        return factory.makeStartViewController()
    }
}
