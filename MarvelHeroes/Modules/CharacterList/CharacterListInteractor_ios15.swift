//
//  CharacterListInteractor_ios15.swift
//  CharacterListInteractor_ios15
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import Foundation

extension CharacterListInteractor {
    func onLoadData() {
        guard let apiRepository = apiRepository as? ApiRepositoryiOS15 else {
            fatalError("Este método sólo se puede llamar con un apiRepository que implemente ApiRepositoryiOS15 -- \(#file) - \(#function)")
        }
        
        self.output?.showLoadingView()
        
        Task {
            do {
                let characters = try await apiRepository.getCharacters()
                self.handleSuccess(characters: characters)
            } catch {
                self.showError()
            }
            
            DispatchQueue.main.async {
                self.output?.hideLoadingView()
            }
        }
    }
}
