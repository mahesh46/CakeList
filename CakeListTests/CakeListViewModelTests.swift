

// CakeListViewModelTests.swift
import XCTest
@testable import CakeList
final class CakeListViewModelTests: XCTestCase {

    // MARK: - Stubs

    final class StubService: CakeServiceProtocol {
        var result: Result<[Cake], Error> = .success([])
        func fetchCakes() async throws -> [Cake] {
            try result.get()
        }
    }

    // MARK: - Tests

    func test_load_success_populatesCakes() async throws {
        // Given
        let service = StubService()
        service.result = .success([
            Cake(id: "1", title: "Victoria Sponge", desc: "Classic", imageUrl: "https://example.com/img1.jpg"),
            Cake(id: "2", title: "Cheesecake", desc: "Creamy", imageUrl: "https://example.com/img2.jpg")
        ])
        let viewModel = CakeListViewModel(service: service)

        // When
        await viewModel.load()

        // Then
        XCTAssertEqual(viewModel.cakes.count, 2)
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_load_failure_setsErrorMessage() async throws {
        // Given
        struct SampleError: Error, LocalizedError {
            var errorDescription: String? { "Sample failure" }
        }
        let service = StubService()
        service.result = .failure(SampleError())
        let viewModel = CakeListViewModel(service: service)

        // When
        await viewModel.load()

        // Then
        XCTAssertTrue(viewModel.cakes.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "Sample failure")
    }
}
