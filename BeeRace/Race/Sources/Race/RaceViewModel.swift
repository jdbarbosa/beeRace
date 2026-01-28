//
//  RaceViewModel.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Foundation
import SwiftUI
import Protocols
import Models
import APIClient

@MainActor
final class RaceViewModel: ObservableObject, ViewModel {

    typealias ViewControllerType = RaceViewController

    private let router: RaceRouter
    private let repository: RaceRepository

    @Published private(set) var raceStatus: [Bee] = []
    @Published private(set) var durationRemaining: Int?
    @Published private(set) var error: Error?

    private var timer: Timer?
    private var elapsedSeconds = 0

    private(set) var isLoading: Bool = false


    init(
        router: RaceRouter,
        repository: RaceRepository
    ) {
        self.router = router
        self.repository = repository
    }

    private func startRace() {
        self.error = nil
        let repository = self.repository
        // Is there any ongoing race?
        if let duration = self.durationRemaining,
           duration > 0 {
            self.resumeRace(duration: duration)
        } else {
            Task {
                do {
                    async let durationRequest = repository.duration()
                    async let dataRequest = repository.raceStatus()

                    let (duration, data) = try await (durationRequest, dataRequest)

                    self.durationRemaining = duration.timeInSeconds
                    self.raceStatus = data.beeList
                    self.resumeRace(duration: duration.timeInSeconds)
                } catch {
                    self.handleError(error)
                }
            }
        }
    }

    func startNewRace() {
        self.durationRemaining = nil
        self.startRace()
    }

    private func resumeRace(duration: Int) {
        self.error = nil
        stopRace()
        durationRemaining = duration
        elapsedSeconds = 0
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true
        ) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.handleTick()
            }
        }
    }


    private func stopRace() {
        timer?.invalidate()
        timer = nil
    }

    private func handleTick() {
        guard let remaining = durationRemaining, remaining > 0 else {
            stopRace()
            self.router.routeToWinner(
                winnerBee: raceStatus.first!,
                delegate: self
            )
            return
        }
        durationRemaining = remaining - 1
        elapsedSeconds += 1

        triggerNewStatus()
    }

    private func triggerNewStatus() {
        let repository = self.repository
        Task {
            do {
                let statusResponse = try await repository.raceStatus()
                self.raceStatus = statusResponse.beeList
            } catch {
                self.handleError(error)
            }
        }
    }

    private func handleError(_ error: Error) {
        stopRace()
        if case APIError.forbidden(let captchaUrl) = error {
            guard let captchaURL = captchaUrl else { return }
            router.routeToCaptcha(
                captchaURL: captchaURL,
                raceViewModelDelegate: self
            )
            return
        }
        self.error = error
    }

    func position(of bee: Bee) -> Int {
        (raceStatus.firstIndex(of: bee) ?? 0) + 1
    }
}

extension RaceViewModel: RaceViewModelDelegate {

    func captchaViewControllerWasDismissed() {
        self.startRace()
    }
}

import RaceWinner

extension RaceViewModel: RaceWinnerRestartable {

    @MainActor
    func didPressRestartRaceButton() {
        self.startNewRace()
    }
}
