//
//  ViewController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/20/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

struct ViewController<Result> {
    private let build: ( @escaping (Result) -> ()) -> UIViewController
    
    init(_ build: @escaping ( @escaping (Result) -> ()) -> UIViewController) {
        self.build = build
    }
    
    func run(completion: @escaping (Result) -> ()) -> UIViewController {
        return build(completion)
    }
    
}

extension UIViewController {
    func presentModal<Result>(flow: NavigationController<Result>, callback: @escaping (Result) -> ()) {
        let viewController = flow.build { [unowned self] result, navigationController in
            callback(result)
            self.dismiss(animated: true, completion: nil)
        }
        viewController.modalTransitionStyle = .coverVertical
        present(viewController, animated: true, completion: nil)
    }
}

func map<A,B>(viewConroller: ViewController<A>, transform: @escaping (A) -> B) -> ViewController<B> {
    return ViewController { callback in
        return viewConroller.run { result in
            callback(transform(result))
        }
    }
}
