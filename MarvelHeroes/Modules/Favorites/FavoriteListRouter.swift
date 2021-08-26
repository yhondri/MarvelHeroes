//
//  FavoriteListRouter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import UIKit

class FavoriteListRouter: FavoriteListWireframe {
    
    var view: FavoriteListView?
    
    func showCredentialsView() {
        let credentialsView = CredentialsRouter.getModule()
        view?.present(credentialsView, animated: true, completion: nil)
    }
    
    func onShowCharacterDetail(character: Character) {
        let characterDetailView = CharacterDetailRouter.getModule(character: character)
        let navController = UINavigationController(rootViewController: characterDetailView)
        view?.present(navController, animated: true, completion: nil)
    }
    
    static func getModule() -> FavoriteListView {
        guard let apiRepository = AppDelegate.sharedAppDelegate()?.mainRouter?.repositories[.apiRepository] as? ApiRepository else {
            fatalError("Cannot initialize this module without apiRepository")
        }
        let router = FavoriteListRouter()
        let presenter = FavoriteListPresenter()
        presenter.router = router
        let interactor = FavoriteListInteractor(apiRepository: apiRepository)
        presenter.interactor = interactor
        let view = FavoriteListView(presenter: presenter)
        router.view = view
        presenter.view = view
        return view
    }
}
