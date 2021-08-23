//
//  CharacterDetailInteractoriOS15.swift
//  CharacterDetailInteractoriOS15
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import UIKit

extension CharacterDetailInteractor {
    func loadComics() {
        guard let apiRepository = apiRepository as? ApiRepositoryiOS15 else {
            fatalError("Este método sólo se puede llamar con un apiRepository que implemente ApiRepositoryiOS15 -- \(#file) - \(#function)")
        }
        Task {
            do {
                let comics = try await apiRepository.getComics(characterId: character.id)
                DispatchQueue.main.async {
                    self.output?.didLoadComics(comics)
                }
            } catch {
                DispatchQueue.main.async {
                    self.output?.showErrorLoadingComics()
                }
            }
        }
    }
}
