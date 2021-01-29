//
//  CounterAPIProtocol.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 21/01/21.
//  Copyright © 2021 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

protocol MeliAPIProtocol {
    func request<T>(serviceResponse: Response<T>, route: RequestConfig, completion: @escaping (Result<T,Error>) -> Void)
}
