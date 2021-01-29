//
//  Configuration.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 21/01/21.
//  Copyright © 2021 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

struct Response<T> {
    var content: (Data) throws -> T
}

protocol RequestConfig {
    var url: URL { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var queryItems: [URLQueryItem] { get }
}

extension RequestConfig {
    var host: String {
        return "api.mercadolibre.com"
    }
    
    var scheme: String {
        return "https"
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}

enum Endpoints: RequestConfig {
    case searchProducts(query: String, page: String)
    case productDetail(id: String)
    
    var path: String {
        switch self {
        case .searchProducts:
            return "/sites/MCO/search"
        case .productDetail(let id):
            return "/items/\(id)"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchProducts(let query, let page):
            return [URLQueryItem(name: "q", value: query),
                    URLQueryItem(name: "offset", value: page)]
        default:
            return []
        }
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else {
            fatalError("Malformed URL \(String(describing: components.string))")
        }
        return url
    }
}

