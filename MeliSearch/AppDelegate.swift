//
//  AppDelegate.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 21/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupFirstVC()
        return true
    }
    
    func setupFirstVC() {
        guard let initialViewController = ProductSearchRouter.createProductSearchModule() else { return }
        let navigationController = UINavigationController(rootViewController: initialViewController)
        setRootVC(with: navigationController)
    }
    
    func setRootVC(with viewController: UIViewController) {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

