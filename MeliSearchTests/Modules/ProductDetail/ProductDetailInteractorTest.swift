//
//  ProductDetailInteractorTest.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import XCTest
@testable import MeliSearch

final class ProductDetailInteractorTest: XCTestCase {
    
    var mockPresenter: MockPresenter!
    var sut: ProductDetailInteractor!
    var mockNetwork: MockNetwork!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockNetwork = MockNetwork()
        sut = ProductDetailInteractor(networkmanager: mockNetwork)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        sut = nil
    }
    
    func test_loadProductDetail_whenSuccess() {
        mockNetwork.mockData = loadJsonResults()
        
        sut.loadProductDetail(with: DummyData.productID)
        
        XCTAssertTrue(mockPresenter.productDetailSuccessCalled)
    }
    
    func test_loadProductDetail_whenFailed() {        
        sut.loadProductDetail(with: DummyData.productID)
        
        XCTAssertTrue(mockPresenter.productDetailFailedCalled)
    }
    
    private func loadJsonResults() -> Data? {
        guard let jsonPath = Bundle(for: type(of: self)).url(forResource: "DetailResult", withExtension: "json") else {
            XCTFail("Missing file: DetailResult.json")
            return nil
        }
        
        return try? Data(contentsOf: jsonPath)
    }
    
    class MockPresenter: ProductDetailInteractorOutputProtocol {
        var productDetailSuccessCalled = false
        var productDetailFailedCalled = false
        
        func productDetailSuccess(with model: ProductDetail) {
            productDetailSuccessCalled = true
        }
        
        func productDetailFailed(with error: Error) {
            productDetailFailedCalled = true
        }
    }
    
    struct DummyData {
        static let productID = "id"
    }
}
