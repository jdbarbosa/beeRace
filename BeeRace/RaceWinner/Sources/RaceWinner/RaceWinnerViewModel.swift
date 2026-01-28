//
//  RaceWinnerViewModel.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Foundation
import Models
import Protocols

@MainActor
final class RaceWinnerViewModel: ObservableObject, ViewModel {

    typealias ViewControllerType = RaceWinnerViewController

    let winnerBee: Bee
    private let router: RaceWinnerRouter
    weak var delegate: RaceWinnerRestartable?

    init(
        winnerBee: Bee,
        router: RaceWinnerRouter,
        delegate: RaceWinnerRestartable?
    ) {
        self.winnerBee = winnerBee
        self.router = router
        self.delegate = delegate
    }

    func restartRace() {
        self.delegate?.didPressRestartRaceButton()
        self.router.newRace()
    }
}
