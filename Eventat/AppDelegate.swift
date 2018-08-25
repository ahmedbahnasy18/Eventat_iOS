//
//  AppDelegate.swift
//  Eventat
//
//  Created by MAC2 on 7/23/18.
//  Copyright © 2018 SourceCode. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    var tabController: MainScreensViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    IQKeyboardManager.shared.enable = true
        L102Localizer.DoTheMagic()
      //  checkLogin()
         setUpNavigationController()
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
    func checkLogin(){
        if let favorites = UserDefaults.standard.data(forKey: "logResp") {
            if favorites.count == 0 {
              
                
            } else {
                print("you're logged in")
                let myStoryboard = UIStoryboard(name: "MainScreens", bundle: nil) as UIStoryboard
                self.tabController = myStoryboard.instantiateViewController(withIdentifier: "MainScreensViewController") as? MainScreensViewController
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = self.tabController
                appDelegate.window?.makeKeyAndVisible()
            }
        } 
        
    }
    //MARK:- Callback Funcs
    func setUpNavigationController(){  //self.navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.appOrange
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) ]
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "System", size: 13)!]
        
    }
}

