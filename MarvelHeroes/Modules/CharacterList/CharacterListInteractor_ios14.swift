//
//  CharacterListInteractor_ios14.swift
//  CharacterListInteractor_ios14
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import Foundation

extension CharacterListInteractor {
    func loadCharacters() {
        output?.showLoadingView()
        
        apiRepository.getCharacters { result in
            switch result {
            case .success(let characters):
                self.handleSuccess(newCharacters: characters)
            case .failure:
                self.showError()
            }
            
            DispatchQueue.main.async {
                self.output?.hideLoadingView()
            }
        }
    }
}
