//
//  CredentialsContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 25/8/21.
//

import Foundation

protocol CredentialsPresentation: AnyObject {
    func onInsertApiKeys(publicKey: String, privateKey: String)
}

protocol CredentialsInteractorInput: AnyObject {
    func onInsertApiKeys(publicKey: String, privateKey: String)
}

protocol CredentialsWireframe: AnyObject {
    func dismiss()
}
