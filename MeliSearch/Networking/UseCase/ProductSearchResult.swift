//
//  ProductSearchResult.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import Foundation

struct ProductSearchResult: Decodable {
    let paging: ProductSearchPaging
    let products: [ProductResult]
    enum CodingKeys: String, CodingKey {
        case products = "results"
        case paging
    }
}
