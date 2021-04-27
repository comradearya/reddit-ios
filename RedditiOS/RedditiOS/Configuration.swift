//
//  Configuration.swift
//  RedditiOS
//
//  Created by orpan on 26.04.2021.
//

import Foundation
import UIKit

struct Configuration {
    
    static let url      = "http://www.reddit.com/r/all/new.json"

    static let limit = 15
    
    static func checkConfiguration() {
        
        if url.isEmpty || limit < 0 {
            fatalError("""
                Invalid configuration found.
            """)
        }
    }
}

struct UIConfiguration {
    static let activityIndicatorColor = UIColor(red: 183/255, green: 21/255, blue: 64/255, alpha: 1.0)
}

