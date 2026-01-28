//
//  RaceWinnerModule.swift
//  RaceWinner
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator

public enum RaceWinnerModule {}

extension Locator.Kind {
    public static var raceWinnerProvider: Locator.Kind<RaceWinnerProvider> { Locator.Kind("RaceWinnerProvider") }
}
public extension RaceWinnerModule {
    static func registerServices(in locator: Locator) {
        let raceWinnerProvider = RaceWinnerProviderImpl(locator: locator)
        locator.register(.raceWinnerProvider, raceWinnerProvider)
    }
}
