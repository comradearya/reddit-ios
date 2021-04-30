//
//  Configuration.swift
//  RedditiOS
//
//  Created by orpan on 26.04.2021.
//

import Foundation
import UIKit

struct NetworkConfiguration {
    
    static let scheme = "http"
    
    static let hostUrl = "www.reddit.com"
    
    static let pathUrl = "/r/memes/top.json"

    static let limit = 15
    
    static func checkConfiguration() {
        
        if hostUrl.isEmpty || limit < 0 {
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
