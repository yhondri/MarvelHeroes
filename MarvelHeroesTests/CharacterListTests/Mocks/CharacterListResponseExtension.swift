//
//  CharacterListResponseExtension.swift
//  CharacterListResponseExtension
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import XCTest
@testable import MarvelHeroes

extension CharacterListResponse {    
    static func getTestData() -> CharacterListResponse {
        let thumbnail = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", imageExtension: "jpg")
        let characters = [Character(id: 1, name: "Hulk", description: "Hulk fuerte", thumbnail: thumbnail),
                          Character(id: 1, name: "A-Bomb (HAS)", description: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ", thumbnail: thumbnail),
                          Character(id: 1, name: "Hulk", description: "", thumbnail: thumbnail),
                          Character(id: 1, name: "Hulk", description: "Hulk fuerte", thumbnail: thumbnail),
                          Character(id: 1, name: "Hulk", description: "Hulk fuerte", thumbnail: thumbnail)]
        let characterListData = CharacterListData(total: 5, characters: characters)
        let response = CharacterListResponse(etag: "123", data: characterListData)
        return response
    }
}
