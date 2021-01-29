//
//  ProductDetail.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import Foundation

struct ProductDetail: Decodable {
    let productName: String
    let price: Int
    let originalPrice: Int?
    let availableQuantity: Int
    let pictures: [ProductPicture]

    enum CodingKeys: String, CodingKey {
        case productName = "title"
        case price
        case originalPrice = "original_price"
        case availableQuantity = "available_quantity"
        case pictures
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pictures =  try container.decode([ProductPicture].self, forKey: .pictures)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.price = try container.decode(Int.self, forKey: .price)
        self.originalPrice = try container.decodeIfPresent(Int.self, forKey: .originalPrice)
        self.availableQuantity = try container.decode(Int.self, forKey: .availableQuantity)
    }
}

struct ProductPicture: Decodable {
    let secureUrl: String
    
    enum CodingKeys: String, CodingKey {
        case secureUrl = "secure_url"
    }
}
