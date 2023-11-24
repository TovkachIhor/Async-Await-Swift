//
//  File.swift
//  
//
//  Created by Ihor Tovkach on 23.11.2023.
//

import Foundation

struct LightDeviceCredential: Codable {
    let type: LightDeviceCredentialType
    let providerId: String
    let key: LightDeviceKey
    let deviceIds: [String]
}
