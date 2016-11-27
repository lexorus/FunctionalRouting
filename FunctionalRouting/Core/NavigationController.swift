//
//  NavigationController.swift
//  CodeWay
//
//  Created by Dmitrii Celpan on 11/20/16.
//  Copyright © 2016 Lexorus. All rights reserved.
//

import UIKit

struct NavigationController<Result> {
    let build: (_ f: @escaping (Result, UINavigationController) -> ()) -> UINavigationController
    
    func run(completion: ((Result) -> ())? = nil) -> UINavigationController {
        return build { (result, navigationController) in
            completion?(result)
        }
    }
    
    func push<B>(_ transform: @escaping (Result) -> ViewController<B>) -> NavigationController<B> {
        return NavigationController<B> { callback in
            let navigationController = self.build { result, navigationController in
                let rootViewController = transform(result).run { result in
                    callback(result, navigationController)
                }
                navigationController.pushViewController(rootViewController, animated: true)
                
            }
            return navigationController
        }
    }
    
    func present<B>(_ transform: @escaping (Result) -> NavigationController<B>) -> NavigationController<B> {
        return NavigationController<B> { callback in
            let navigationController = self.build { result, navigationController in
                navigationController.presentModal(flow: transform(result)) { result in
                    callback(result, navigationController)
                }
                
            }
            return navigationController
        }
    }
    
}

func navigationController<Result>(_ viewController: ViewController<Result>) -> NavigationController<Result> {
    return NavigationController { callback in
        let navigationController = UINavigationController()
        let rootController = viewController.run(completion: { result in
            callback(result, navigationController)
        })
        navigationController.viewControllers = [rootController]
        return navigationController
    }
}

precedencegroup LeftAssociativity {
    associativity: left
    higherThan: DefaultPrecedence
}

infix operator >>> : LeftAssociativity

func >>><A,B>(lhs: NavigationController<A>, rhs: @escaping (A) -> ViewController<B>) -> NavigationController<B> {
    return lhs.push(rhs)
}

func + <A, B> (lhs: NavigationController<A>, rhs: @escaping (A) -> NavigationController<B>) -> NavigationController<B> {
    return lhs.present(rhs)
}

func map<A,B>(navigationController: NavigationController<A>,
         transform: @escaping (A) -> B) -> NavigationController<B> {
    return NavigationController { callback in
        return navigationController.build { (y, nc) in
            callback(transform(y), nc)
        }
    }
}

func flatMap<A, B>(lhs: NavigationController<A>,
             transform: @escaping ((A) -> NavigationController<B>)) -> NavigationController<B> {
    return NavigationController<B> { callback in
        let navigationController = lhs.build({ (result, navigationController) in
            let _ = transform(result).build(callback)
        })
        
        return navigationController
    }
}
