//
//  ProductSearchInteractor.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//
import Foundation

final class ProductSearchInteractor: ProductSearchInteractorProtocol {
    weak var presenter: ProductSearchInteractorOutputProtocol?
    var networkmanager: MeliAPIProtocol?
    
    init(networkmanager: MeliAPIProtocol? = MeliAPI()) {
        self.networkmanager = networkmanager
    }
    
    func searchProducts(with text: String, numberOfPage: Int) {
        let content: (Data) throws -> ProductSearchResult = { data in
            return try JSONDecoder().decode(ProductSearchResult.self, from: data)
        }
        
        let response = Response(content: content)
        networkmanager?.request(serviceResponse: response,
                                route: Endpoints.searchProducts(query: text, page: String(numberOfPage)),
                                completion: { [weak self] (result) in
                                    switch result {
                                    case .success(let response):
                                        self?.presenter?.searchProductSuccess(with: response)
                                    case .failure(let error):
                                        self?.presenter?.searchProductFailed(with: error)
                                    }
        })
    }
}
