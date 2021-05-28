//
//  AppDelegate.swift
//  ShoeApp
//
//  Created by Кирилл Клименков on 8.05.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        
        
        let tabBar = UITabBarController()
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        let mainVC = ViewController()
        mainVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        tabBar.viewControllers = [myVC(mainVC), myVC(searchVC)]
        
//        NavigationManager.shared.navigationController.viewControllers = [vc]
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func myVC(_ viewController: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }

}

class NavigationManager {
    
    static let shared = NavigationManager()
    
    let navigationController: UINavigationController
    
    private init() {
        self.navigationController = UINavigationController()
    }
}
