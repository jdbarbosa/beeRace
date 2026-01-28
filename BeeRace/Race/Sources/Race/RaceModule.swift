//
//  RaceModule.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator

public enum RaceModule {}

extension Locator.Kind {
    public static var raceProvider: Locator.Kind<RaceProvider> { Locator.Kind("RaceProvider") }
}
public extension RaceModule {
    static func registerServices(in locator: Locator) {
        let raceProvider = RaceProviderImpl(locator: locator)
        locator.register(.raceProvider, raceProvider)
    }
}
