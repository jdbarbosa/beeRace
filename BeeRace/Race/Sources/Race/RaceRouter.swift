//
//  RaceRouter.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import Models
import RaceWinner

protocol RaceRouter {
    @MainActor func routeToWinner(
        winnerBee: Bee,
        delegate: RaceWinnerRestartable?
    )

    @MainActor func routeToCaptcha(
        captchaURL: URL,
        raceViewModelDelegate: RaceViewModelDelegate?
    )
}

final class RaceRouterImpl: RaceRouter {

    private let viewController: UIViewController
    private let raceWinnerProvider: RaceWinnerProvider

    init(
        viewController: UIViewController,
        raceWinnerProvider: RaceWinnerProvider
    ) {
        self.viewController = viewController
        self.raceWinnerProvider = raceWinnerProvider
    }

    @MainActor func routeToWinner(
        winnerBee: Bee,
        delegate: RaceWinnerRestartable?
    ) {
        guard let raceWinnerViewController = raceWinnerProvider.raceWinnerViewController(
            winnerBee: winnerBee,
            delegate: delegate
        ) else { return }
        guard let navigationController = viewController.navigationController else { return }
        navigationController.pushViewController(raceWinnerViewController, animated: true)
    }

    @MainActor func routeToCaptcha(
        captchaURL: URL,
        raceViewModelDelegate: RaceViewModelDelegate?
    ) {
        let captchaVC = CaptchaURLViewController(
            url: captchaURL,
            delegate: raceViewModelDelegate
        )
        let navController = UINavigationController(rootViewController: captchaVC)
        viewController.present(navController, animated: true)
    }
}
