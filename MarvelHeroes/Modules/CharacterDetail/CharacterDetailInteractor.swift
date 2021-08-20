//
//  CharacterDetailInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import UIKit

class CharacterDetailInteractor: CharacterDetailInteractorInput {
    weak var output: CharacterDetailInteractorOutput?
    let apiRepository: ApiRepository
    var character: Character
    
    init(character: Character, apiRepository: ApiRepository) {
        self.character = character
        self.apiRepository = apiRepository
    }
}
