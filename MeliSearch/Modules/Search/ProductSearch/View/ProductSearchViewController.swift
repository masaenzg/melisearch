//
//  ProductSearchViewController.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//
import UIKit

final class ProductSearchViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: ProductSearchPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Buscar"
        navigationItem.searchController = search
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        registerCellForTableView()
    }
    
    private func registerCellForTableView() {
        tableView.registerUINib(nibName: ProductResultTableViewCell.viewID)
    }
    
    private func setupSpinnerFooterView() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: .zero,
                               y: .zero,
                               width: tableView.bounds.width,
                               height: 44)
        return spinner
    }
    
    private func loadMoreRows() {
        guard let loadMoreRows = presenter?.shouldLoadMoreRows() else { return }
        if loadMoreRows {
            self.tableView.tableFooterView?.isHidden = false
            presenter?.getMoreResults()
        }
    }
}

extension ProductSearchViewController: ProductSearchViewProtocol {
    func reloadData() {
        tableView.reloadData()
        tableView.tableFooterView?.isHidden = true
    }
}

extension ProductSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        presenter?.searchProduct(with: text)
    }
}

extension ProductSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductResultTableViewCell.viewID, for: indexPath) as? ProductResultTableViewCell,
            let row = presenter?.selectedRow(with: indexPath.row) else {
                return UITableViewCell()
        }
        cell.setup(with: row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: .zero) - 1
        if indexPath.row == lastRowIndex {
            let spinner = setupSpinnerFooterView()
            self.tableView.tableFooterView = spinner
            loadMoreRows()
        } else {
            self.tableView.tableFooterView?.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.sendToDetail(with: indexPath.row)
    }
}
