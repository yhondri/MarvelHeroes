//
//  FavoriteListInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import Foundation

class FavoriteListInteractor: FavoriteInteractorInput {
    private let apiRepository: ApiRepository
    var favoriteIds: Set<Int64> {
        apiRepository.getFavoriteIds()
    }
    var favorites: [Character] {
        apiRepository.getFavorites()
    }

    init(apiRepository: ApiRepository) {
        self.apiRepository = apiRepository
    }
    
    func onSelectFavorite(character: Character) {
        apiRepository.onSelectFavorite(character: character)
    }
}
