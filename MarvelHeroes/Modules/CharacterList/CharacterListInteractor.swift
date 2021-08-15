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
        apiRepository.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
    }
    
    func onLoadData() {
        if #available(iOS 15.0, *) {
            Task {
                do {
                    let characters = try await apiRepository.getCharacters()
                    self.handleSuccess(characters: characters)
                } catch {
                    self.output?.onErrorLoadingCharacters()
                }
            }
        } else {
            apiRepository.getCharacters { result in
                switch result {
                case .success(let characters):
                    self.handleSuccess(characters: characters)
                case .failure:
                    self.output?.onErrorLoadingCharacters()
                }
            }
        }
    }
    
    private func handleSuccess(characters: [Character]) {
        self.output?.onDidLoadCharacters(characters)
        if !self.didSuccessFirstLoading && !characters.isEmpty {
            self.output?.onHideApiKeysDialog()
            self.didSuccessFirstLoading = true
        }
    }
    
}
