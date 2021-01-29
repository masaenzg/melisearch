//
//  ProductSearchPaging.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import Foundation

struct ProductSearchPaging: Decodable {
    var total: Int
    var page: Int
    var limit: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "offset"
        case total
        case limit
    }
}
