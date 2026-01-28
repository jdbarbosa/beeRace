//
//  Untitled.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import APIClient
import Models

protocol RaceRepository: Sendable {
    func duration() async throws -> DurationResponse
    func raceStatus() async throws -> RaceStatusRaceResponse
}

final class RaceRepositoryImpl: RaceRepository {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func duration() async throws -> DurationResponse {
        try await apiClient.sendURLSessionRequest(for: DurationRequest())
    }

    func raceStatus() async throws -> RaceStatusRaceResponse {
        try await apiClient.sendURLSessionRequest(for: RaceStatusRequest())
    }
}

struct DurationResponse: Codable {
    let timeInSeconds: Int
}

struct RaceStatusRaceResponse: Codable, Sendable {
    let beeList: [Bee]
}
