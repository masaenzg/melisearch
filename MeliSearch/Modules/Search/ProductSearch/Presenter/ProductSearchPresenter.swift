//
//  ProductSearchPresenter.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//
import UIKit

final class ProductSearchPresenter: ProductSearchPresenterProtocol {
    
    weak var view: ProductSearchViewProtocol?
    var router: ProductSearchRouterProtocol?
    var interactor: ProductSearchInteractorProtocol?
    var searchText: String = String()
    var numberOfPage: Int = .zero
    var rowsPerPage: Int = .zero
    var totalRows: Int = .zero
    var results: [ProductResult] = []
    private var searchingWorkItem: DispatchWorkItem?
    
    func numberOfRows() -> Int {
        return results.count
    }
    
    func selectedRow(with index: Int) -> ProductResult {
        return results[index]
    }
    
    func sendToDetail(with index: Int) {
        let productId = results[index].id
        router?.presentProductDetail(with: productId)
    }
    
    func searchProduct(with text: String) {
        searchingWorkItem?.cancel()
        if text.isEmpty {
            numberOfPage = .zero
            return
        }
        searchText = text
        let currentWorkItem = DispatchWorkItem { [weak self] in
            guard let strongSelf = self else { return }
            self?.interactor?.searchProducts(with: text, numberOfPage: strongSelf.numberOfPage)
        }
        searchingWorkItem = currentWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: currentWorkItem)
    }
    
    func getMoreResults() {
        numberOfPage += 1
        if shouldLoadMoreRows() {
            searchProduct(with: searchText)
        }
    }
    
    func shouldLoadMoreRows() -> Bool {
        return ((numberOfPage + 1) * rowsPerPage) < totalRows
    }
}

extension ProductSearchPresenter: ProductSearchInteractorOutputProtocol {
    func searchProductSuccess(with model: ProductSearchResult) {
        rowsPerPage = model.paging.limit
        totalRows = model.paging.total
        if model.paging.page == 0 {
            results = model.products
        } else {
            results.append(contentsOf: model.products)
        }
        view?.reloadData()
    }
    
    func searchProductFailed(with error: Error) {
        router?.presentErrorAlert(with: error)
    }
}
