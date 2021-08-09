//
//  Action.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

struct Action<Output> {
    let baseUrl: String?
    let path: String
    let method: HttpMethod
    let inputData: Encodable?
    let parser: Parser<Output>
    let headers: [String: String]?
    
    init(_ method: HttpMethod = .get,
         baseUrl: String? = nil,
         path: String,
         inputData: Encodable? = nil,
         parser: Parser<Output>,
         headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.inputData = inputData
        self.parser = parser
        self.headers = headers
    }
}

extension Action where Output: Decodable {
    init(_ method: HttpMethod = .get,
         baseUrl: String? = nil,
         path: String,
         inputData: Encodable? = nil,
         headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.inputData = inputData
        self.parser = .json()
        self.headers = headers
    }
}

import UIKit
extension Action where Output == UIImage {
    init(_ method: HttpMethod = .get,
         baseUrl: String? = nil,
         path: String,
         inputData: Encodable? = nil,
         headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.inputData = inputData
        self.parser = .image()
        self.headers = headers
    }
}

extension Action where Output == String {
    init(_ method: HttpMethod = .get,
         baseUrl: String? = nil,
         path: String,
         inputData: Encodable? = nil,
         headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.inputData = inputData
        self.parser = .string()
        self.headers = headers
    }
}

extension Action where Output == Data {
    init(_ method: HttpMethod = .get,
         baseUrl: String? = nil,
         path: String,
         inputData: Encodable? = nil,
         headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.inputData = inputData
        self.parser = .data()
        self.headers = headers
    }
}

extension Action where Output == Void {
    init(_ method: HttpMethod = .get,
         baseUrl: String? = nil,
         path: String,
         inputData: Encodable? = nil,
         headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
        self.inputData = inputData
        self.parser = .void()
        self.headers = headers
    }
}
