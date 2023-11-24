//
//  File.swift
//  
//
//  Created by Ihor Tovkach on 23.11.2023.
//

import Foundation

enum LightDeviceKey: Codable {
    case saltoKey(SaltoKey)
    
    private enum CodingKeys: String, CodingKey {
        case saltoKey = "salto_key"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let saltoKey = try container.decodeIfPresent(SaltoKey.self, forKey: .saltoKey) {
            self = .saltoKey(saltoKey)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .saltoKey, in: container, debugDescription: "Invalid key type")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .saltoKey(let saltoKey):
            try container.encode(saltoKey, forKey: .saltoKey)
        }
    }
}

struct SaltoKey: Codable {
    let mobileKey: String
}
