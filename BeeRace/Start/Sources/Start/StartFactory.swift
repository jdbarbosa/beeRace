//
//  StartFactory.swift
//  Start
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import Race

public protocol StartFactory {
    @MainActor
    func makeStartViewController() -> UIViewController?
}

package final class StartFactoryImpl: StartFactory {

    private let raceProvider: RaceProvider

    init(raceProvider: RaceProvider) {
        self.raceProvider = raceProvider
    }

    @MainActor
    public func makeStartViewController() -> UIViewController? {
        let startViewController = StartViewController()
        let router = StartRouterImpl(
            viewController: startViewController,
            raceProvider: raceProvider
        )
        let viewModel = StartViewModel(router: router)
        startViewController.bind(viewModel: viewModel)
        return startViewController

    }
}
