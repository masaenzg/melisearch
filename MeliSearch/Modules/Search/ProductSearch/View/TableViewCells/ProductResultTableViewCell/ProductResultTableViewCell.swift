//
//  ProductResultTableViewCell.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import UIKit

class ProductResultTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setup(with model: ProductResult) {
        productNameLabel.text = model.title
        productPriceLabel.text = String(model.value)
        guard let url = URL(string: model.imageUrl) else {
           return
        }
        productImage.load(url: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
}
