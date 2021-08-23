//
//  MainRouter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 23/8/21.
//

import UIKit

enum RepositoryKey {
    case apiRepository
}
protocol MainRouter: AnyObject {
    var repositories: [RepositoryKey: Any] { get }
    func start()
}

class MainRouterImpl: MainRouter {
    private let window: UIWindow?
    lazy var repositories: [RepositoryKey : Any] = {
        [.apiRepository: ApiRepositoryImpl()]
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let repository: ApiRepository = repositories[.apiRepository] as? ApiRepository else {
            fatalError("Cannot run the app without ApiRepository")
        }
        let navController = UINavigationController(rootViewController: CharacterListRouter.getModule(repository: repository))
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
