//
//  CakeService.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//

import Foundation

final class CakeService: CakeServiceProtocol {
    private let urlString = "https://raw.githubusercontent.com/Waracle/mobile-coding-test-api/refs/heads/main/cakes"
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCakes() async throws -> [Cake] {
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Cake].self, from: data)
    }
}
