//
//  File.swift
//  
//
//  Created by Ihor Tovkach on 23.11.2023.
//

import Foundation

struct HealthRequest: Codable {}

struct HealthResponse: Codable {
    let note: String
    let ok: Bool
}

struct CredentialsRequest: Codable {}

struct CredentialsResponse: Codable {
    let credentials: [LightDeviceCredential]
}

protocol LightApiClientProtocol {
    func health() async throws -> LightApiResult<HealthResponse>
    func credentials() async throws -> LightApiResult<CredentialsResponse>
}
