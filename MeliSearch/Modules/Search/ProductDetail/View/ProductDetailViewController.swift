//
//  ProductDetailViewController.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright (c) 2021 msaenz. All rights reserved.
//
import UIKit

final class ProductDetailViewController: UIViewController, Storyboarded {
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availlablleTitleLabel: UILabel!
    
    var presenter: ProductDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadProductInfo()
    }
    
    private func setupOriginalpriceLabel(with text: String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: 2,
                                     range: NSMakeRange(0, attributeString.length))
        originalPriceLabel.attributedText = attributeString
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {
    func presentviewInformation(with model: ProductDetailModel) {
        productNameLabel.text = model.name
        if let url = model.image {
            productImageView.load(url: url)
        }
        setupOriginalpriceLabel(with: model.originalPrice)
        originalPriceLabel.isHidden = model.originalPrice == String()
        priceLabel.text = model.price
        availlablleTitleLabel.text = "Stock Disponible \(model.availableQuantity)"
    }
}
