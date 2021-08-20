//
//  CharacterListInteractor_ios14.swift
//  CharacterListInteractor_ios14
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import Foundation

extension CharacterListInteractor {
    func onLoadData() {
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
