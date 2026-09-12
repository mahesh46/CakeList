//
//  Cake.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//

import Foundation

struct Cake: Decodable, Hashable, Comparable, Identifiable {
    var id: String { title } // Using title as unique identifier
    let title: String
    let desc: String
    let image: String

    static func < (lhs: Cake, rhs: Cake) -> Bool {
        return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
    }
}
