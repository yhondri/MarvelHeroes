//
//  CredentialsPresenter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 25/8/21.
//

import Foundation

class CredentialsPresenter: CredentialsPresentation {
    
    var interactor: CredentialsInteractorInput?
    var router: CredentialsWireframe?
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        interactor?.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
        router?.dismiss()
    }
}
