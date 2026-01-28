//
//  RaceFactory.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import UIKit
import APIClient
import RaceWinner

public protocol RaceFactory {
    @MainActor
    func makeRaceViewController(
        apiClient: APIClient
    ) -> UIViewController?
}

package final class RaceFactoryImpl: RaceFactory {

    private let raceWinnerProvider: RaceWinnerProvider

    init(raceWinnerProvider: RaceWinnerProvider) {
        self.raceWinnerProvider = raceWinnerProvider
    }

    @MainActor
    public func makeRaceViewController(
        apiClient: APIClient
    ) -> UIViewController? {
        let raceViewController = RaceViewController()
        let repository = RaceRepositoryImpl(apiClient: apiClient)
        let router = RaceRouterImpl(
            viewController: raceViewController,
            raceWinnerProvider: raceWinnerProvider
        )
        let viewModel = RaceViewModel(
            router: router,
            repository: repository
        )
        raceViewController.bind(viewModel: viewModel)
        return raceViewController

    }
}
