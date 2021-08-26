//
//  CredentialsInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 25/8/21.
//

import Foundation

class CredentialsInteractor: CredentialsInteractorInput {
    private let apiRepository: ApiRepository
        
    init(apiRepository: ApiRepository) {
        self.apiRepository = apiRepository
    }
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        apiRepository.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
    }
}
