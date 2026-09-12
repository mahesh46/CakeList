//
//  CakeListTests.swift
//  CakeListTests
//
//  Created by mahesh lad on 11/09/2026.
//

import XCTest
@testable import CakeList

final class MockCakeService: CakeServiceProtocol {
    var resultToReturn: Result<[Cake], Error>?

    func fetchCakes() async throws -> [Cake] {
        guard let result = resultToReturn else {
            fatalError("Result not configured")
        }
        return try result.get()
    }
}

@MainActor
final class CakeListViewModelTests: XCTestCase {
    
    private var sut: CakeListViewModel!
    private var mockService: MockCakeService!

    override func setUp() {
        super.setUp()
        mockService = MockCakeService()
        sut = CakeListViewModel(service: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    // Test 1: Load succeeds -> Duplicates removed and sorted
    func test_loadCakes_succeeds_deduplicatesAndSorts() async {
        // Given
        let duplicate1 = Cake(title: "Banana Cake", desc: "Tasty", image: "url1")
        let duplicate2 = Cake(title: "Banana Cake", desc: "Tasty", image: "url1")
        let firstAlphabetically = Cake(title: "Apple Cake", desc: "Sweet", image: "url2")
        
        mockService.resultToReturn = .success([duplicate1, duplicate2, firstAlphabetically])

        // When
        await sut.loadCakes()

        // Then
        if case .loaded(let cakes) = sut.state {
            XCTAssertEqual(cakes.count, 2, "Duplicates should be removed")
            XCTAssertEqual(cakes.first?.title, "Apple Cake", "List should be sorted alphabetically")
            XCTAssertEqual(cakes.last?.title, "Banana Cake")
        } else {
            XCTFail("Expected state to be .loaded, got \(sut.state)")
        }
    }

    // Test 2: Load fails -> Error presented
    func test_loadCakes_fails_presentsError() async {
        // Given
        let expectedError = URLError(.notConnectedToInternet)
        mockService.resultToReturn = .failure(expectedError)

        // When
        await sut.loadCakes()

        // Then
        if case .error(let message) = sut.state {
            XCTAssertFalse(message.isEmpty)
        } else {
            XCTFail("Expected state to be .error, got \(sut.state)")
        }
    }
}

