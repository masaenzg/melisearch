//
//  ProductDetailInteractor.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//

import UIKit

final class ProductDetailInteractor: ProductDetailInteractorProtocol {
    weak var presenter: ProductDetailInteractorOutputProtocol?
    var networkmanager: MeliAPIProtocol?
    
    init(networkmanager: MeliAPIProtocol? = MeliAPI()) {
        self.networkmanager = networkmanager
    }
    
    func loadProductDetail(with id: String) {
        let content: (Data) throws -> ProductDetail = { data in
            return try JSONDecoder().decode(ProductDetail.self, from: data)
        }
        
        let response = Response(content: content)
        networkmanager?.request(serviceResponse: response,
                                route: Endpoints.productDetail(id: id),
                                completion: { [weak self] (result) in
                                    switch result {
                                    case .success(let response):
                                        self?.presenter?.productDetailSuccess(with: response)
                                    case .failure(let error):
                                        self?.presenter?.productDetailFailed(with: error)
                                    }
        })    }
}
