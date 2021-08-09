//
//  CharacterListRouter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class CharacterListRouter: CharacterListWireframe {
    func onShowCharacterDetail(character: Character) {
        guard let currentController = AppDelegate.sharedAppDelegate()?.window?.rootViewController else {
            return
        }
        
        let characterDetailView = CharacterDetailRouter.getModule(character: character)
        let navController = UINavigationController(rootViewController: characterDetailView)
        currentController.present(navController, animated: true, completion: nil)
    }
    
    static func getModule(repository: ApiRepository) -> CharactersListView {
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        presenter.router = router
        let interactor = CharacterListInteractor(apiRepository: repository)
        interactor.output = presenter
        presenter.interactor = interactor
        let view = CharactersListView(presenter: presenter)
        presenter.view = view
        return view
    }
}
