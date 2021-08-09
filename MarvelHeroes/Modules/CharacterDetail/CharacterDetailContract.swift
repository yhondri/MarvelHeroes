//
//  CharacterDetailContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import UIKit

protocol CharacterDetailPresentation: AnyObject {
    var character: Character { get }
    func viewDidLoad(navController: UINavigationController)
    func loadComics()
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
    func viewDidLoad(navController: UINavigationController)
}

protocol CharacterDetailView: AnyObject {
    func showComics(_ comics: [Comic])
    func showErrorLoadingComics()
}
