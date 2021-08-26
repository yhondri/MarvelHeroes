//
//  CharacterListRouter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class CharacterListRouter: CharacterListWireframe {
    var view: CharactersListView?

    func onShowCharacterDetail(character: Character) {
        let characterDetailView = CharacterDetailRouter.getModule(character: character)
        let navController = UINavigationController(rootViewController: characterDetailView)
        view?.present(navController, animated: true, completion: nil)
    }
    
    func showCredentialsView() {
        let credentialsView = CredentialsRouter.getModule()
        view?.present(credentialsView, animated: true, completion: nil)
    }
    
    static func getModule(repository: ApiRepository, moduleType: ModuleType) -> CharactersListView {
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
        presenter.router = router
        let interactor = CharacterListInteractor(apiRepository: repository, moduleType: moduleType)
        interactor.output = presenter
        presenter.interactor = interactor
        let view = CharactersListView(presenter: presenter)
        presenter.view = view
        router.view = view
        return view
    }
}
