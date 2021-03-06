 //
//  AppDelegate.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-23.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
       configureInitialRootViewController(for: window)
        
        UIApplication.shared.statusBarStyle = .lightContent

        
        // 1
        let storyboard = UIStoryboard(name: "Login", bundle: .main)
        
        // 2
        if let initialViewController = storyboard.instantiateInitialViewController() {
            // 3
            window?.rootViewController = initialViewController
            // 4
            window?.makeKeyAndVisible()
        }
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginStoryboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)

        var initialViewController: UIViewController
        let userDefault = UserDefaults.standard
        let loggedIn = userDefault.bool(forKey: "loggedIn")
        if(loggedIn == true) {
            initialViewController = (mainStoryboard.instantiateViewController(withIdentifier: "home"))
        }
        else {
            initialViewController = (loginStoryboard.instantiateViewController(withIdentifier: "first"))
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

        UINavigationBar.appearance().barTintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
//        UINavigationBar.appearance().tintColor = UIColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 226/255, green: 232/255, blue: 228/255, alpha: 1)]
        UITabBar.appearance().tintColor = UIColor(red: 224/255.0, green: 40/255.0, blue: 104/255.0, alpha: 1.0)
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
    }


}

extension AppDelegate {
    func configureInitialRootViewController(for window: UIWindow?) {
        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        if Auth.auth().currentUser != nil,
            let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User {
            
            User.setCurrent(user)
            
            initialViewController = UIStoryboard.initialViewController(for: .main)
        } else {
            initialViewController = UIStoryboard.initialViewController(for: .login)
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}
