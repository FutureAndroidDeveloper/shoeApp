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
        
        let vc = ViewController()
        NavigationManager.shared.navigationController.viewControllers = [vc]
        window?.rootViewController = NavigationManager.shared.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

class NavigationManager {
    
    static let shared = NavigationManager()
    
    let navigationController: UINavigationController
    
    private init() {
        self.navigationController = UINavigationController()
    }
}
