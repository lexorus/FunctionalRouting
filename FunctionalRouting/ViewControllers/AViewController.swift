//
//  AViewController.swift
//  FunctionalRouting
//
//  Created by Dmitrii Celpan on 11/24/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

func aViewController() -> ViewController<()> {
    return ViewController { completion in
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AViewController") as! AViewController
        vc.onComplete = completion
        
        return vc
    }
}

final class AViewController: UIViewController {
    var onComplete: (() -> ())?
    
    // VERY COMPLICATED LOGIC (related only to this ViewController/Module)
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        onComplete?()
    }
    
}
