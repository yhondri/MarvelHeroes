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
    var favoriteIds: Set<Int64> {
        apiRepository.getFavoriteIds()
    }
        
    init(apiRepository: ApiRepository) {
        self.apiRepository = apiRepository
    }
    
    func onSelectFavorite(character: Character) {
        apiRepository.onSelectFavorite(character: character)
    }
}


