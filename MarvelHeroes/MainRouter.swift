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
        
        let characterListNavController = UINavigationController(rootViewController: CharacterListRouter.getModule(repository: repository))
        characterListNavController.tabBarItem = UITabBarItem(title: LocalizedKey.characters.localized,
                                           image: UIImage(systemName: "person.3")!,
                                           selectedImage: UIImage(systemName: "person.3.fill")!)
        
        let favoriteListNavController = UINavigationController(rootViewController: FavoriteListRouter.getModule())
        favoriteListNavController.tabBarItem = UITabBarItem(title: LocalizedKey.favorites.localized,
                                           image: UIImage(systemName: "star")!,
                                           selectedImage: UIImage(systemName: "star.fill")!)
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [favoriteListNavController, characterListNavController]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
