//
//  Configuration.swift
//  RedditiOS
//
//  Created by orpan on 26.04.2021.
//

import Foundation
import UIKit

struct NetworkConfiguration {
    
    static let url      = "http://www.reddit.com"

    static let limit = 15
    
    static func checkConfiguration() {
        
        if url.isEmpty || limit < 0 {
            fatalError("""
                Invalid configuration found.
            """)
        }
    }
}

struct Configuration {
    
    static let newsCellIdentifier = "newsCell"
    
    static let postEntityName = "Post"

}
