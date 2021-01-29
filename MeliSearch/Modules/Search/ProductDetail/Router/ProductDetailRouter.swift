//
//  ProductDetailRouter.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import UIKit

final class ProductDetailRouter: ProductDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createProductDetailModule(with productId: String) -> ProductDetailViewController? {
        guard let ref = ProductDetailViewController.instantiate(from: .productDetail) else { return nil }
        
        let presenter: ProductDetailPresenterProtocol & ProductDetailInteractorOutputProtocol = ProductDetailPresenter()
        presenter.productId = productId
        
        let router = ProductDetailRouter()
        router.viewController = ref
        
        let interactor = ProductDetailInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        
        ref.presenter = presenter
        return ref
    }
    
    func presentErrorAlert(with error: Error) {
        guard let viewController = viewController else { return }
        let completion: ((UIAlertAction) -> Void)? = { [weak self] _ in
            self?.viewController?.navigationController?.popViewController(animated: true)
        }
        error.alert(with: viewController, completion: completion)
    }
}

