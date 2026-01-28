//
//  RaceRequest.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import APIClient
import Foundation

final class RaceStatusRequest: APIRequest {

    typealias Response = RaceStatusRaceResponse

    var httpRequestMethod: HTTPRequestMethod = .get
    var path: String

    var additionalHeaders: [String : String]?
    var httpBody: Data?
    var queryItems: [URLQueryItem]?

    init() {
        self.path = "/status"
    }
}
