//
//  StartViewRouter.swift
//  Start
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import Race

protocol StartRouter {
    @MainActor func goToRace()
}

final class StartRouterImpl: StartRouter {

    private let viewController: UIViewController
    private let raceProvider: RaceProvider

    init(
        viewController: UIViewController,
        raceProvider: RaceProvider
    ) {
        self.raceProvider = raceProvider
        self.viewController = viewController
    }

    @MainActor
    func goToRace() {
        guard let raceViewController = raceProvider.raceViewController() else { return }
        guard let navigationController = viewController.navigationController else { return }
        navigationController.pushViewController(raceViewController, animated: true)
    }
}
