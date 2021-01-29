//
//  ProductSearchRouter.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import UIKit

final class ProductSearchRouter: ProductSearchRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createProductSearchModule() -> ProductSearchViewController? {
        guard let ref = ProductSearchViewController.instantiate(from: .productSearch) else { return nil }
        
        let presenter: ProductSearchPresenterProtocol & ProductSearchInteractorOutputProtocol = ProductSearchPresenter()
        
        let router = ProductSearchRouter()
        router.viewController = ref
        
        let interactor = ProductSearchInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
    
    func presentProductDetail(with productId: String) {
        guard let productDetail = ProductDetailRouter.createProductDetailModule(with: productId) else { return }
        viewController?.navigationController?.pushViewController(productDetail, animated: true)
    }
    
    func presentErrorAlert(with error: Error) {
        guard let viewController = viewController else { return }
        error.alert(with: viewController)
    }
}

