//
//  NewsViewModel.swift
//  RedditiOS
//
//  Created by orpan on 24.04.2021.
//

import Foundation

public struct NewsForView: Hashable {
    var title: String
    var newsDescription: String
    var created: Date
    var author: String
    var numberOfComments: Int
    var imageUrl: String
    var postUrl: String
}
