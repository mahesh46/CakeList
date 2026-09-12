//
//  FailingCakesTests.swift
//  CakeList
//
//  Created by mahesh lad on 11/09/2026.
//

import Testing
import XCTest
@testable import CakeList



private struct ThrowingService: CakeServiceProtocol {
    struct SampleError: LocalizedError, Equatable {
        var errorDescription: String? { "Sample failure" }
    }
    func fetchCakes() async throws -> [Cake] { throw SampleError() }
}

@Suite("CakeListViewModel loadCakes error path")
struct CakeListViewModelLoadCakesErrorTests {

    @Test("sets state to .error with localizedDescription when service throws")
    @MainActor
    func setsErrorStateOnFailure() async {
        // Arrange
        let service = ThrowingService()
        let sut = CakeListViewModel(service: service)

        // Precondition
        #expect({ if case .idle = sut.state { return true } else { return false } }())

        // Act
        await sut.loadCakes()

        // Assert
        #expect({
            if case let .error(message) = sut.state { return message == "Sample failure" }
            return false
        }(), "State should be .error with the thrown error's localizedDescription")
    }
}
