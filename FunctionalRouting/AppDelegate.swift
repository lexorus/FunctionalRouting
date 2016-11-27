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
        
        let mainFLow = navigationController(aViewController())
            >>> bViewController
            >>> cViewController
            >>> dViewController
        
        let additionalFlow = navigationController(bViewController())
            >>> fViewController
            >>> aViewController
        
        let transitionToAdditionalFlow: (() -> NavigationController<()>) = {
            return additionalFlow
        }
        
        let combinedFlows = mainFLow + transitionToAdditionalFlow
        
        window?.rootViewController = combinedFlows.run {
            print("Combined flows finished")
        }

        return true
    }
    
}

