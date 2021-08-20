//
//  NetworkDispatcheriOS15Extension.swift
//  NetworkDispatcheriOS15Extension
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import Foundation

protocol DispatcheriOS15: Dispatcher {
    @discardableResult
    @available(iOS 15.0, *)
    func execute<T: Decodable>(action: Action<T>) async throws -> T
}

extension NetworkDispatcher: DispatcheriOS15 {    
    @available(iOS 15.0, *)
    @discardableResult
    func execute<T: Decodable>(action: Action<T>) async throws -> T {
        let request = buildRequest(for: action)
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        return try decoder.decode(T.self, from: data)
    }
}
