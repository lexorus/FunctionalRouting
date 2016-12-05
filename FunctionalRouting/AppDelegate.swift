//
//  AppDelegate.swift
//  FunctionalRouting
//
//  Created by Dmitrii Celpan on 11/24/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let flow1 = navigationController(aViewController())
            >>> cViewController
            >>> bViewController
        
        let flow2 = navigationController(cViewController())
            >>> bViewController
            >>> fViewController
        
        let flow1ToFlow2: () -> NavigationController<()> = {
            return flow2
        }
        
        let composedFlows = flow1 + flow1ToFlow2
        
        window?.rootViewController = composedFlows.run(completion: {
            print("a flow finished")
        })
        
        return true
    }
    
}

