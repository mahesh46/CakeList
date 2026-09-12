//
//  CakeServiceProtocol.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//

import Foundation

protocol CakeServiceProtocol {
    func fetchCakes() async throws -> [Cake]
}

