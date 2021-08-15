//
//  ComicListResponseExtension.swift
//  ComicListResponseExtension
//
//  Created by Yhondri Acosta Novas on 15/8/21.
//

import XCTest
@testable import MarvelHeroes

extension ComicsListResponse {
    static func getTestData() -> ComicsListResponse {
        let thumbnail = Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/10/5a612c90dfdb5", imageExtension: "jpg")
        let comic = Comic(id: 65941, title: "Iron Man Epic Collection: Doom (Trade Paperback)", thumbnail: thumbnail, description: "Collects Iron Man (1968) #245-257, Annual #10-11 and material from Captain America Annual #9. Iron Man and Doctor Doom face off in the future! The armored foes renew their rivalry in a future version of Camelot, where they must join a reborn Arthur and Merlin in battle against some very familiar faces! Then, Loki cultivates chaos as his Acts of Vengeance pit shell-head against the Wrecker and Chemistro! Inside the armor, Tony Stark continues to come to terms with his paralysis, and the Maggia makes its move — but what is its involvement with Hydra and A.I.M.? Plus: Iron Man and Crimson Dynamo see the world through each other’s eyes! Tony defends the surface when Atlantis attacks! Iron Man and Captain America join forces to deal with the return of Terminus! And don’t forget the Dreadnoughts, Madame Masque, the Hulk and…Santa Claus?!")
        let comics = [comic, comic, comic, comic, comic, comic, comic, comic]
        let data = ComicListData(total: 1, comics: comics)
        let response = ComicsListResponse(etag: "", data: data)
        return response
    }
}
