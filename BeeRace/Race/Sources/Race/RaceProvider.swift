//
//  RaceProvider.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator
import APIClient
import UIKit

public protocol RaceProvider {

    @MainActor func raceViewController() -> UIViewController?
}

public struct RaceProviderImpl: RaceProvider {

    private weak var locator: Locator?
    private let factory: RaceFactory

    public init(locator: Locator) {
        self.locator = locator
        self.factory = RaceFactoryImpl(
            raceWinnerProvider: locator.resolve(.raceWinnerProvider)
        )
    }

    @MainActor public func raceViewController() -> UIViewController? {
        guard let locator = locator else {
            fatalError("Locator is not set")
        }
        return factory.makeRaceViewController(
            apiClient: locator.resolve(.apiClient)
        )
    }
}
