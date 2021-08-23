//
//  NetworkDispatcher.swift
//
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

class NetworkDispatcher: Dispatcher {
    var baseUrl: String
    private lazy var publicApiKey: String = "" //Empty keep safe
    private lazy var privateApiKey: String = "" //Empty keep safe
    private(set) lazy var decoder = JSONDecoder()

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    @discardableResult
    func execute<Output>(action: Action<Output>) -> NetworkTask<Output> {
        let task = NetworkTask<Output>()
        let request = buildRequest(for: action)
        let sessionTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = DispatcherError(request: request, data: data, response: response, error: error) {
                task.complete(error)
                return
            } else {
                task.complete(data, parser: action.parser)
            }
        }
        
        task.cancelBlock = sessionTask.cancel
        sessionTask.resume()
        
        return task
    }
    
    func buildRequest<Output>(for action: Action<Output>) -> URLRequest {
        let path = appendCredentialsToPath(action.path)
        guard let url = URL(string: (action.baseUrl ?? baseUrl).appending(path)) else {
            preconditionFailure("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = action.method.rawValue
        if let body = action.inputData?.jsonData() {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        action.headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
            
        return request
    }
    
    func cleanURLSessionCache() {
        URLCache.shared.removeAllCachedResponses()
    }
    
    private func appendCredentialsToPath(_ path: String) -> String {
        let timeStamp = Date.currentTimeStamp
        let hash = String(format: "%d%@%@", timeStamp, privateApiKey, publicApiKey).md5Value
        return String(format: "%@ts=%d&apikey=%@&hash=%@", path, timeStamp, publicApiKey, hash)
    }
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        self.publicApiKey = publicKey
        self.privateApiKey = privateKey
    }
}

struct ServerErrorCode: Decodable {
    let code: Int
}

extension DispatcherError {
    init?(request: URLRequest, data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            print("FAILED Network error: ", error.localizedDescription)
            self = .networkError(error)
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("FAILED No data available")
            self = .noData
            return
        }
        
        guard response.statusCode != 304 else {
            self = .serverError(code: response.statusCode, statusCode:  response.statusCode)
            return
        }
        
        guard response.statusCode >= 200, response.statusCode < 300 else {
            if let data = data, let errorCode = try? JSONDecoder().decode(ServerErrorCode.self, from: data) {
                self = .serverError(code: errorCode.code, statusCode:  response.statusCode)
            } else {
                self = .serverError(code: response.statusCode, statusCode: nil)
            }
            return
        }
        
        return nil
    }
}

extension Encodable {
    func jsonData() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print(error)
            return nil
        }
    }
}

extension URLRequest {
    var description: String {
        return "\(httpMethod ?? "GET") '\(url?.absoluteString ?? "/")'"
    }
    var debugDescription: String {
        var description = "- START ---------------------\n"
        description += "\(httpMethod ?? "GET") '\(url?.absoluteString ?? "/")'"
        if let headers = allHTTPHeaderFields, !headers.isEmpty {
            description += "\nHeaders: [\n"
            for (key, value) in headers {
                description += "  \(key) : \(value)\n"
            }
            description += "]"
        }
        if let bodyData = httpBody, let body = String(data: bodyData, encoding: .utf8) {
            description += "\nBody: \(body)\n"
        }
        description += "\n- END ------------------------"
        return description
    }
}
