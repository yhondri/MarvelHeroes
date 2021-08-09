//
//  CharacterListInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

class CharacterListInteractor: CharacterListInteractorInput {
    
    weak var output: CharacterListInteractorOutput?
    private let apiRepository: ApiRepository
    private var didSuccessFirstLoading = false
        
    init(apiRepository: ApiRepository) {
        self.apiRepository = apiRepository
    }
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
//        apiRepository.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
    }
    
    func onLoadData() {
        apiRepository.getCharacters { result in
            switch result {
            case .success(let characters):
                self.output?.onDidLoadCharacters(characters)
                if !self.didSuccessFirstLoading && !characters.isEmpty {
                    self.output?.onHideApiKeysDialog()
                    self.didSuccessFirstLoading = true
                }
            case .failure:
                self.output?.onErrorLoadingCharacters()
            }
        }
    }
}
