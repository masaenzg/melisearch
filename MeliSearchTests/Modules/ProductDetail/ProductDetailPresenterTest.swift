////
////  ProductDetailPresenterTest.swift
////  MeliSearch
////
////  Created by Manuel Adolfo Saenz Grijalba on 28/01/21.
////  Copyright (c) 2021 msaenz. All rights reserved.
////
//
//import XCTest
//@testable import MeliSearch
//
//final class ProductDetailPresenterTest: XCTestCase {
//
//    var mockView: MockView!
//    var mockRouter: MockRouter!
//    var mockInteractor: MockInteractor!
//    var sut: ProductDetailPresenter!
//
//    override func setUp() {
//        super.setUp()
//        mockView = MockView()
//        mockRouter = MockRouter()
//        mockInteractor = MockInteractor()
//        sut = ProductDetailPresenter()
//        sut.view = mockView
//        sut.router = mockRouter
//        sut.interactor = mockInteractor
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        mockView = nil
//        mockRouter = nil
//        mockInteractor = nil
//        sut = nil
//    }
//
//    class MockView: ProductDetailViewProtocol {
//        var presenter: ProductDetailPresenterProtocol?
//    }
//
//    class MockRouter: ProductDetailRouterProtocol {
//        var viewController: BaseViewController?
//
//        static func createProductDetailModule() -> ProductDetailViewController {
//            return ProductDetailViewController()
//        }
//    }
//
//    class MockInteractor: ProductDetailInteractorProtocol {
//        var presenter: ProductDetailInteractorOutputProtocol?
//    }
//
//    struct DummyData {
//
//    }
//}
