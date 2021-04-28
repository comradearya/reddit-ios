//
//  Array+Extension.swift
//  RedditiOS
//
//  Created by orpan on 28.04.2021.
//

import Foundation

extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
