//
//  MockNetwork.swift
//  MeliSearchTests
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import Foundation
@testable import MeliSearch

class MockNetwork: MeliAPIProtocol {
    var mockData: Data? = nil
    func request<T>(serviceResponse: Response<T>, route: RequestConfig, completion: @escaping (Result<T, Error>) -> Void) {
        completion(
            Result {
                guard let data = mockData else {
                    throw ErrorAPI.notDataFound
                }
                if let dataParsed = try? serviceResponse.content(data) {
                    return dataParsed
                } else {
                    throw ErrorAPI.unableParse
                }
            }
        )
    }

    class FakeDataTask: URLSessionTask {
        override init() { }
    }
}
