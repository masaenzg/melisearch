//
//  ProductSearchProtocols.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//
import UIKit

protocol ProductSearchInteractorProtocol: AnyObject {
    var presenter: ProductSearchInteractorOutputProtocol? { get set }
    var networkmanager: MeliAPIProtocol? { get set }
    
    func searchProducts(with text: String, numberOfPage: Int)
}

protocol ProductSearchPresenterProtocol: AnyObject {
    var view: ProductSearchViewProtocol? { get set }
    var router: ProductSearchRouterProtocol? { get set }
    var interactor: ProductSearchInteractorProtocol? { get set }
    
    func numberOfRows() -> Int
    func selectedRow(with index: Int) -> ProductResult
    func sendToDetail(with index: Int)
    func searchProduct(with text: String)
    func getMoreResults()
    func shouldLoadMoreRows() -> Bool
}

protocol ProductSearchInteractorOutputProtocol: AnyObject {
    func searchProductSuccess(with model: ProductSearchResult)
    func searchProductFailed(with error: Error)
}

protocol ProductSearchRouterProtocol: BaseRouterProtcol {
    var viewController: UIViewController? { get set }
    
    static func createProductSearchModule() -> ProductSearchViewController?
    func presentProductDetail(with productId: String)
}

protocol ProductSearchViewProtocol: AnyObject {
    var presenter: ProductSearchPresenterProtocol? { get set }
    
    func reloadData()
}
