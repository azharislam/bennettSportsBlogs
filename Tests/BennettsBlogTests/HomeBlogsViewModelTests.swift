//
//  HomeBlogsViewModelTests.swift
//  BennettsBlogTests
//
//  Created by Azhar Islam on 13/08/2023.
//

import XCTest

@testable import BennettsBlog

class HomeBlogsViewModelTests: XCTestCase {
    
    var viewModel: HomeBlogsViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = HomeBlogsViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testFetchPhotosSuccess() {
        mockAPIService.fetchPhotosResult = .success([Blog]())
        
        let expectation = self.expectation(description: "Fetching photos succeeds")
        
        viewModel.fetchPhotos()
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
        XCTAssertNotNil(viewModel.fetchPhotos())
    }
    
    func testFetchPhotosError() {
        mockAPIService.fetchPhotosResult = .failure(APIError.noData)
        
        let expectation = self.expectation(description: "Fetching photos fails")
        
        viewModel.fetchPhotos()
        
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.error)
    }
}

class MockAPIService: APIServiceProtocol {
    
    var fetchPhotosResult: Result<[Blog], Error>!
    
    func fetchPhotos(completion: @escaping (Result<[Blog], Error>) -> Void) {
        completion(fetchPhotosResult)
    }
}
