//
//  RaceWinnerRouter.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import Models

protocol RaceWinnerRouter {
    @MainActor func newRace()
}

final class RaceWinnerRouterImpl: RaceWinnerRouter {

    private let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    @MainActor
    func newRace() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
