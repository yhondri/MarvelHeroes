//
//  NetworkTask.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation
import os.log

class NetworkTask<Output>: Cancellable {
    var isCancelled: Bool = false
    var cancelBlock: (() -> Void)?
    var alwaysBlock: (() -> Void)? {
        didSet {
            guard !isCancelled, output != nil || error != nil else { return }
            alwaysBlock?()
        }
    }
    
    private(set) var output: Output? {
        didSet {
            guard oldValue == nil, error == nil, let output = output else {
                preconditionFailure("Invalid output value")
            }
            guard !isCancelled else { return }
            alwaysBlock?()
            completionBlock?(output)
        }
    }
    
    private(set) var completionBlock: ((Output) -> Void)? {
        didSet {
            guard !isCancelled, let output = output else { return }
            completionBlock?(output)
        }
    }
    
    private(set) var error: DispatcherError? {
        didSet {
            guard output == nil, oldValue == nil, let error = error else {
                preconditionFailure("Invalid error value")
            }
            guard !isCancelled else { return }
            alwaysBlock?()
            errorBlock?(error)
        }
    }
    
    private(set) var errorBlock: ((DispatcherError) -> Void)? {
        didSet {
            guard !isCancelled, let error = error else { return }
            errorBlock?(error)
        }
    }
    
    func cancel() {
        guard !isCancelled else { return }
        isCancelled = true
        cancelBlock?()
    }
    
    @discardableResult
    func always(_ alwaysBlock: @escaping (() -> Void)) -> Self {
        self.alwaysBlock = alwaysBlock
        return self
    }
    
    @discardableResult
    func then(_ completionBlock: @escaping ((Output) -> Void)) -> Self {
        self.completionBlock = completionBlock
        return self
    }
    
    @discardableResult
    func `catch`(_ errorBlock: @escaping ((DispatcherError) -> Void)) -> Self {
        self.errorBlock = errorBlock
        return self
    }
    
    func complete(_ error: DispatcherError) {
        self.error = error
    }
    
    func complete(_ output: Output) {
        self.output = output
    }
    
    func complete(_ data: Data?, parser: Parser<Output>) {
        do {
            guard let data = data, !data.isEmpty, let output = try parser.parseData(data) else {
                self.error = .noData
                return
            }
            self.output = output
        } catch {
            os_log("Error with service: %@", log: OSLog.default, type: .error, error.localizedDescription)
            debugPrint("Error parsing ", error)
            self.error = .badData(error)
        }
    }
}
