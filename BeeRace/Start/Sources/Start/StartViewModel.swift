//
//  StartViewModel.swift
//  Start
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Foundation
import Protocols

@MainActor
final class StartViewModel: ObservableObject, ViewModel {

    typealias ViewControllerType = StartViewController

    private let router: StartRouter

    init(
        router: StartRouter
    ) {
        self.router = router
    }

    func goToRace() {
        self.router.goToRace()
    }
}
