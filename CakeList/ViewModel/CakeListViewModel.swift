//
//  CakeListViewModel.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//

import Foundation
import Combine
import Observation

@Observable
@MainActor
final class CakeListViewModel {
    private(set) var state: ViewState = .idle
    private let service: CakeServiceProtocol
    
    init(service: CakeServiceProtocol = CakeService()) {
        self.service = service
    }
    
    func loadCakes() async {
        state = .loading
        do {
            let rawCakes = try await service.fetchCakes()
            
            // Remove duplicates and sort
            let processedCakes = Array(Set(rawCakes)).sorted()
            
            state = .loaded(processedCakes)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
