//
//  AppDelegate.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private(set) lazy var repository: ApiRepository = ApiRepositoryImpl()
    
    lazy var window: UIWindow? = {
        let window = UIWindow()
        window.tintColor = .systemBlue
        return window
    }()
    
    class func sharedAppDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        let navController = UINavigationController(rootViewController: CharacterListRouter.getModule(repository: repository))
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

        return true
    }
}

