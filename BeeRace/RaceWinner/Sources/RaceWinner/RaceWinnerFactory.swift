//
//  RaceWinnerFactory.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import APIClient
import Models

public protocol RaceWinnerFactory {
    @MainActor
    func makeRaceWinnerViewController(
        winnerBee: Bee,
        delegate: RaceWinnerRestartable?
    ) -> UIViewController?
}

package final class RaceWinnerFactoryImpl: RaceWinnerFactory {

    init() {}

    @MainActor
    public func makeRaceWinnerViewController(
        winnerBee: Bee,
        delegate: RaceWinnerRestartable?
    ) -> UIViewController? {
        let raceWinnerViewController = RaceWinnerViewController()
        let router = RaceWinnerRouterImpl(viewController: raceWinnerViewController)
        let viewModel = RaceWinnerViewModel(
            winnerBee: winnerBee,
            router: router,
            delegate: delegate
        )
        raceWinnerViewController.bind(viewModel: viewModel)
        return raceWinnerViewController
    }
}
