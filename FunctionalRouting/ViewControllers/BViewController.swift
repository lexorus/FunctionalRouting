//
//  BViewController.swift
//  FunctionalRouting
//
//  Created by Dmitrii Celpan on 11/24/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

func bViewController() -> ViewController<()> {
    return ViewController { completion in
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BViewController") as! BViewController
        viewController.onComplete = completion
        
        return viewController
    }
}

final class BViewController: UIViewController {
    var onComplete: (() -> ())?
    
    // VERY COMPLICATED LOGIC (related only to this ViewController/Module)
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        onComplete?()
    }
    
}
