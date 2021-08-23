//
//  CharacterDetailContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import UIKit

protocol CharacterDetailPresentation: AnyObject {
    var character: Character { get }
    func loadComics()
    func showComicDetail(_ comic: Comic)
}

protocol CharacterDetailInteractorInput: AnyObject {
    var character: Character { get }
    func loadComics()
}

protocol CharacterDetailInteractorOutput: AnyObject {
    func didLoadComics(_ comics: [Comic])
    func showErrorLoadingComics()
}

protocol CharacterDetailWireframe: AnyObject {
    func showComicDetail(_ comic: Comic)
}

protocol CharacterDetailView: AnyObject {
    func showComics(_ comics: [Comic])
    func showErrorLoadingComics()
}
