//
//  Navigation.swift
//  RedditiOS
//
//  Created by orpan on 26.04.2021.
//

import UIKit

enum StoryBoard: String {
    case main = "Main"
}

struct Navigation {
    
    static func getViewController<T: UIViewController>(_ storyboard: StoryBoard = .main, type: T.Type, identifer: String) -> T? {
        
        let storyBoard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        guard let viewController = storyBoard.instantiateViewController(withIdentifier: identifer) as? T else { return nil }
        return viewController
    }
}
