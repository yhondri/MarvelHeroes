//
//  CredentialsRouter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 25/8/21.
//

import UIKit

class CredentialsRouter: CredentialsWireframe {
    
    var view: CredentialsViewController?
    
    func dismiss() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    static func getModule() -> CredentialsViewController {
        guard let apiRepository = AppDelegate.sharedAppDelegate()?.mainRouter?.repositories[.apiRepository] as? ApiRepository else {
            fatalError("Cannot initialize this module without apiRepository")
        }
        let interactor = CredentialsInteractor(apiRepository: apiRepository)
        let presenter = CredentialsPresenter()
        presenter.interactor = interactor
        let router = CredentialsRouter()
        presenter.router = router
        let view = CredentialsViewController(presenter: presenter)
        router.view = view
        return view
    }
}
