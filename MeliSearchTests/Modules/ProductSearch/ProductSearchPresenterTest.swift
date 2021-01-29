//
//  ProductSearchPresenterTest.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import XCTest
@testable import MeliSearch

final class ProductSearchPresenterTest: XCTestCase {
    
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!
    var sut: ProductSearchPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = ProductSearchPresenter()
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        sut = nil
    }
    
    func test_numberOfRows() {
        sut.results = loadResults()?.products ?? []
        
        let rows = sut.numberOfRows()
        
        XCTAssertGreaterThanOrEqual(rows, 0)
    }
    
    func test_selectedRow() {
        sut.results = loadResults()?.products ?? []
        
        let row = sut.selectedRow(with: 0)
        
        XCTAssertNotNil(row)
    }
    
    func test_sendToDetail() {
        sut.results = loadResults()?.products ?? []
        
        sut.sendToDetail(with: 0)
        
        XCTAssertTrue(mockRouter.presentProductDetailCalled)
    }
    
    func test_searchProduct_whenTextIsEmpty() {
        sut.searchProduct(with: String())
        
        XCTAssertEqual(sut.numberOfPage, 0)
    }
    
    func test_getMoreResults() {
        sut.results = loadResults()?.products ?? []
        sut.rowsPerPage = loadResults()?.paging.limit ?? .zero
        sut.totalRows = loadResults()?.paging.total ?? .zero
        
        sut.getMoreResults()
    }
    
    private func loadResults() -> ProductSearchResult? {
        guard let data = loadJsonResults() else { return nil }
        let results = try? JSONDecoder().decode(ProductSearchResult.self, from: data)
        return results
    }
    
    private func loadJsonResults() -> Data? {
        guard let jsonPath = Bundle(for: type(of: self)).url(forResource: "SearchResults", withExtension: "json") else {
            XCTFail("Missing file: SearchResults.json")
            return nil
        }
        
        return try? Data(contentsOf: jsonPath)
    }
    
    class MockView: ProductSearchViewProtocol {
        var presenter: ProductSearchPresenterProtocol?
        var reloadDataCalled = false
        
        func reloadData() {
            reloadDataCalled = true
        }
    }
    
    class MockRouter: ProductSearchRouterProtocol {
        var viewController: UIViewController?
        var presentProductDetailCalled = false
        var presentErrorAlertCalled = false
        
        static func createProductSearchModule() -> ProductSearchViewController? {
            return ProductSearchViewController()
        }
        
        func presentProductDetail(with productId: String) {
            presentProductDetailCalled = true
        }
        
        func presentErrorAlert(with error: Error) {
            presentErrorAlertCalled = true
        }
    }
    
    class MockInteractor: ProductSearchInteractorProtocol {
        var presenter: ProductSearchInteractorOutputProtocol?
        var networkmanager: MeliAPIProtocol?
        var searchProductsCalled = false
        
        func searchProducts(with text: String, numberOfPage: Int) {
            searchProductsCalled = true
        }
    }
    
    struct DummyData {
        static let searchText = "search"
    }
}
