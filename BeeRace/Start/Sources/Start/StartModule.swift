//
//  StartModule.swift
//  Start
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator

public enum StartModule {}

extension Locator.Kind {
    public static var startProvider: Locator.Kind<StartProvider> { Locator.Kind("StartProvider") }
}
public extension StartModule {
    static func registerServices(in locator: Locator) {
        let startProvider = StartProviderImpl(locator: locator)
        locator.register(.startProvider, startProvider)
    }
}
