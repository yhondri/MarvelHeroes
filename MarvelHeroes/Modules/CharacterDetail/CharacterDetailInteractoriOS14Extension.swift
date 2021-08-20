//
//  CharacterDetailInteractoriOS14.swift
//  CharacterDetailInteractoriOS14
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//

import UIKit

extension CharacterDetailInteractor {    
    func loadComics() {
        apiRepository.getComics(characterId: character.id) { result in
            switch result {
            case .success(let comics):
                self.output?.didLoadComics(comics)
            case .failure:
                self.output?.showErrorLoadingComics()
            }
        }
    }
}
