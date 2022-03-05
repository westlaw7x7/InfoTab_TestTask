//
//  AppStartManager.swift
//  InfoTab_TestTask
//
//  Created by Alexander Grigoryev on 05.03.2022.
//

import UIKit

final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let rootVC = TableViewController()
        rootVC.navigationItem.title = "Персональные данные"
        
        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.gray
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}
