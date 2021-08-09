//
//  CharacterDetailInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import UIKit

class CharacterDetailInteractor: CharacterDetailInteractorInput {
    
    weak var output: CharacterDetailInteractorOutput?
    private let apiRepository: ApiRepository
    var character: Character
    
    init(character: Character, apiRepository: ApiRepository) {
        self.character = character
        self.apiRepository = apiRepository
    }
    
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
