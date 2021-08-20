//
//  CharacterListInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

class CharacterListInteractor: CharacterListInteractorInput {
    weak var output: CharacterListInteractorOutput?
    var didSuccessFirstLoading = false
    let apiRepository: ApiRepository
        
    init(apiRepository: ApiRepository) {
        self.apiRepository = apiRepository
    }
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        apiRepository.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
    }
}


