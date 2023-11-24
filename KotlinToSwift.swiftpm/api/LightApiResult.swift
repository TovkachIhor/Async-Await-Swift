//
//  File.swift
//  
//
//  Created by Ihor Tovkach on 23.11.2023.
//

import Foundation

enum LightApiResult<T> {
    case successTest(T)
    case failure(LightApiError)
}

struct LightApiSuccess<T> {
    let data: T
}

struct LightApiFailure<T> {
    let error: LightApiError
}
