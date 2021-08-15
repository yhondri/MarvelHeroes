//
//  Dispatcher.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

enum DispatcherError: Error {
    case networkError(Error)
    case serverError(code: Int, statusCode: Int?)
    case unauthorized
    case educamosUserSMAForm
    case mochilaUserSMAForm
    case unknown
    case noData
    case badData(Error)
}

enum LocalError: Error {
    case invalidResponse
    case unknownError
}

protocol Dispatcher: AnyObject {
    func onInsertApiKeys(publicKey: String, privateKey: String)

    @discardableResult
    func execute<Output>(action: Action<Output>) -> NetworkTask<Output>
    
    @discardableResult
    @available(iOS 15.0, *)
    func execute<T: Decodable>(action: Action<T>) async throws -> T

    func cleanURLSessionCache()
}
