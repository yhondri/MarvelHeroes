//
//  Parser.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

struct Parser<Output> {
    let parseBlock: (Data?) throws -> Output?
    
    func parseData(_ data: Data?) throws -> Output? {
        return try parseBlock(data)
    }
}

extension Parser {
    static func void() -> Parser<Void> {
        return Parser<Void> { _ in }
    }
    
    static func data() -> Parser<Data> {
        return Parser<Data> { $0 }
    }
    
    static func json<Output: Decodable>(decoder: JSONDecoder = JSONDecoder()) -> Parser<Output> {
        return Parser<Output> {
            guard let data = $0 else { return nil }
            return try decoder.decode(Output.self, from: data)
        }
    }
    
    static func image() -> Parser<UIImage> {
        return Parser<UIImage> {
            guard let data = $0 else { return nil }
            return UIImage(data: data)
        }
    }
    
    static func string(encoding: String.Encoding = .utf8) -> Parser<String> {
        return Parser<String> {
            guard let data = $0 else { return nil }
            return String(data: data, encoding: encoding)
        }
    }
    
    static func boolean() -> Parser<Bool> {
        return Parser<Bool> {
            guard let data = $0,
                let result = String(data: data, encoding: .utf8).flatMap(Bool.init) else { return false }
            return result
        }
    }
}
