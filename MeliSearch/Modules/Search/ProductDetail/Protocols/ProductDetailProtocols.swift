//
//  ProductDetailProtocols.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import UIKit

protocol ProductDetailInteractorProtocol: AnyObject {
    var presenter: ProductDetailInteractorOutputProtocol? { get set }
    var networkmanager: MeliAPIProtocol? { get set }
    
    func loadProductDetail(with id: String)
}

protocol ProductDetailPresenterProtocol: AnyObject {
    var view: ProductDetailViewProtocol? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    var interactor: ProductDetailInteractorProtocol? { get set }
    var productId: String? { get set }
    
    func loadProductInfo()
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func productDetailSuccess(with model: ProductDetail)
    func productDetailFailed(with error: Error)
}

protocol ProductDetailRouterProtocol: BaseRouterProtcol {
    var viewController: UIViewController? { get set }
    
    static func createProductDetailModule(with productId: String) -> ProductDetailViewController?
}

protocol ProductDetailViewProtocol: AnyObject {
    var presenter: ProductDetailPresenterProtocol? { get set }
    
    func presentviewInformation(with model: ProductDetailModel)
}
