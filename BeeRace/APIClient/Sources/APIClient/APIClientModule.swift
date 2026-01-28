//
//  APIClientModule.swift
//  APIClient
//
//  Created by Joao Barbosa on 26/01/2026.
//

import Locator

public enum APIClientModule {}

extension Locator.Kind {
    public static var apiClient: Locator.Kind<APIClient> { Locator.Kind("APIClient") }
}

public extension APIClientModule {
    static func registerServices(in locator: Locator) {
        let client = BeeRaceAPIClient()
        locator.register(.apiClient, client)
    }
}
