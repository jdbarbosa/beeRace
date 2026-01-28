//
//  RaceWinnerProvider.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator
import APIClient
import UIKit
import Models

public protocol RaceWinnerProvider {
    @MainActor func raceWinnerViewController(
        winnerBee: Bee,
        delegate: RaceWinnerRestartable?
    ) -> UIViewController?
}

public struct RaceWinnerProviderImpl: RaceWinnerProvider {

    private let locator: Locator

    public init(locator: Locator) {
        self.locator = locator
    }

    @MainActor public func raceWinnerViewController(
        winnerBee: Bee,
        delegate: RaceWinnerRestartable?
    ) -> UIViewController? {
        let factory = RaceWinnerFactoryImpl()
        return factory.makeRaceWinnerViewController(
            winnerBee: winnerBee,
            delegate: delegate
        )
    }
}
