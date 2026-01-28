//
//  DurationRequest.swift
//  Race
//
//  Created by Joao Barbosa on 26/01/2026.
//

import APIClient
import Foundation

final class DurationRequest: APIRequest {

    typealias Response = DurationResponse

    var httpRequestMethod: HTTPRequestMethod = .get
    var path: String

    var additionalHeaders: [String : String]?
    var httpBody: Data?
    var queryItems: [URLQueryItem]?

    init() {
        self.path = "/duration"
    }
}
