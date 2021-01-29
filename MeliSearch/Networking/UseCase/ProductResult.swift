//
//  ProductResult.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import Foundation

struct ProductResult: Decodable {
    let id: String
    let freeShipping: Bool
    let imageUrl: String
    let title: String
    let value: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "thumbnail"
        case shipping
        case title
        case value = "price"
    }
    
    enum FreeShipingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let shippingContainer = try container.nestedContainer(keyedBy: FreeShipingKeys.self, forKey: .shipping)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.freeShipping =  try shippingContainer.decode(Bool.self, forKey: .freeShipping)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.title = try container.decode(String.self, forKey: .title)
        self.value = try container.decode(Int.self, forKey: .value)        
    }
}
