//
//  ProductDetailPresenter.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import UIKit

final class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    weak var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var interactor: ProductDetailInteractorProtocol?
    var productId: String?
    
    func loadProductInfo() {
        guard let productId = self.productId else { return }
        interactor?.loadProductDetail(with: productId)
    }
    
    private func getProductImage(with imageList: [ProductPicture]) -> URL? {
        guard let firstImage = imageList.first,
            let imageURL = URL(string: firstImage.secureUrl) else { return nil }
        return imageURL
    }
    
    private func valueToString(with value: Int?) -> String {
        guard let value = value else { return String() }
        return String(value)
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func productDetailSuccess(with model: ProductDetail) {
        let viewModel = ProductDetailModel(name: model.productName,
                                           image: getProductImage(with: model.pictures),
                                           originalPrice: valueToString(with: model.originalPrice),
                                           price: String(model.price),
                                           availableQuantity: String(model.availableQuantity))
        view?.presentviewInformation(with: viewModel)
    }
    
    func productDetailFailed(with error: Error) {
        router?.presentErrorAlert(with: error)
    }
}
