//
//  CharacterDetailRouter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import UIKit

class CharacterDetailRouter: CharacterDetailWireframe {
    
    var viewController: UIViewController?
    
    func showComicDetail(_ comic: Comic) {
        guard let navController = viewController?.navigationController else {
            debugPrint("Cannot show this module without navController")
            return
        }
        let comicDetailView = ComicDetailViewController(comic: comic)
        navController.pushViewController(comicDetailView, animated: true)
    }
    
    static func getModule(character: Character) -> CharacterDetailViewController {
        guard let apiRepository = AppDelegate.sharedAppDelegate()?.repository else {
            fatalError("Cannot initialize this module without apiRepository")
        }
        
        let presenter = CharacterDetailPresenter()
        let interactor = CharacterDetailInteractor(character: character, apiRepository: apiRepository)
        interactor.output = presenter
        presenter.interactor = interactor
        let router = CharacterDetailRouter()
        presenter.router = router
        let view = CharacterDetailViewController(presenter: presenter)
        presenter.view = view
        router.viewController = view        
        return view
    }    
}
