//
//  Bee.swift
//  Models
//
//  Created by Joao Barbosa on 26/01/2026.
//

public struct Bee: Codable, Sendable, Equatable {
    public let name: String
    public let color: String

    public init (name: String, color: String) {
        self.name = name
        self.color = color
    }
}
