//
//  File.swift
//  
//
//  Created by Ihor Tovkach on 23.11.2023.
//

import Foundation
import Alamofire

class LightApiClient: LightApiClientProtocol {
    
    private func toJSON<T: Encodable>(obj: T) -> Parameters? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        if let data = try? encoder.encode(obj) {
            return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        }
        return nil
    }
    
    private func request<T: Decodable, R: Encodable>(path: String, body: R, method: HTTPMethod = .post) async throws -> LightApiResult<T> {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(Api.BaseUrl)\(path)", method: method, parameters: toJSON(obj: body), encoding: URLEncoding.default, headers: nil)
                .responseDecodable(of: T.self, completionHandler: { response in
                    switch response.result {
                    case .success(let result):
                        guard let responseType = response.response?.value(forHTTPHeaderField: "content-type") else {
                            continuation.resume(throwing: NSError(domain: "Invalid response", code: 0))
                            return
                        }
                        if (responseType.range(of: "application/json", options: .caseInsensitive) == nil) {
                            continuation.resume(throwing: NSError(domain: "Invalid response type \(responseType)", code: 0))
                            return
                        }
                        continuation.resume(returning: .successTest(result))
                    case .failure(let error):
                        continuation.resume(returning: .failure(LightApiError(message: error.localizedDescription, code: response.response?.statusCode ?? 0)))
                    }
                })
        }
    }
    
    func health() async throws -> LightApiResult<HealthResponse> {
        return try await request(path: "/health", body: HealthRequest(), method: .get)
    }
    
    func credentials() async throws -> LightApiResult<CredentialsResponse> {
        return try await request(path: "/credentials", body: CredentialsRequest())
    }
}

struct Api {
    static let BaseUrl = "https://connect.light.co"
}
