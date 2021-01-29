//
//  ProductSearchInteractorTest.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import XCTest
@testable import MeliSearch

final class ProductSearchInteractorTest: XCTestCase {
    
    var mockPresenter: MockPresenter!
    var sut: ProductSearchInteractor!
    var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockNetwork = MockNetwork()
        sut = ProductSearchInteractor(networkmanager: mockNetwork)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        mockPresenter = nil
        sut = nil
        mockNetwork = nil
        super.tearDown()
    }
    
    func test_searchProducts_whenSucess() {
        mockNetwork.mockData = loadJsonResults()
        
        sut.searchProducts(with: DummyData.searchText, numberOfPage: DummyData.page)
        
        XCTAssertTrue(mockPresenter.searchProductSuccessCalled)
    }
    
    func test_searchProducts_whenFailed() {
        sut.searchProducts(with: DummyData.searchText, numberOfPage: DummyData.page)
        
        XCTAssertTrue(mockPresenter.searchProductFailedCalled)
    }
    
    private func loadJsonResults() -> Data? {
        guard let jsonPath = Bundle(for: type(of: self)).url(forResource: "SearchResults", withExtension: "json") else {
            XCTFail("Missing file: SearchResults.json")
            return nil
        }
        
        return try? Data(contentsOf: jsonPath)
    }
    
    class MockPresenter: ProductSearchInteractorOutputProtocol {
        var searchProductSuccessCalled = false
        var searchProductFailedCalled = false
        
        func searchProductSuccess(with model: ProductSearchResult) {
            searchProductSuccessCalled = true
        }
        
        func searchProductFailed(with error: Error) {
            searchProductFailedCalled = true
        }
    }
    
    struct DummyData {
        static let searchText = "search"
        static let page = 0
    }
}
