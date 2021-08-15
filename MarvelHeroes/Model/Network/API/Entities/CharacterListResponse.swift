//
//  CharacterListResponse.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

struct CharacterListResponse: Decodable {
    let etag: String
    let data: CharacterListData
}
