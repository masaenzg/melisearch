//
//  CounterAPI.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 21/01/21.
//  Copyright © 2021 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

class MeliAPI: MeliAPIProtocol {
    func request<T>(serviceResponse: Response<T>, route: RequestConfig, completion: @escaping (Result<T,Error>) -> Void) {
        if !Reachability.isConnectedToNetwork() {
            completion(Result { throw ErrorAPI.internetConnectionFailed })
        }
        let request = setupRequest(with: route)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.manageResponse(data: data, response: serviceResponse, completion: completion)
            }
        }
        task.resume()
    }
    
    private func setupRequest(with route: RequestConfig) -> URLRequest {
        var urlRequest = URLRequest(url: route.url)
        urlRequest.httpMethod = route.method.rawValue
        urlRequest.allHTTPHeaderFields = route.headers
        return urlRequest
    }
    
    private func manageResponse<T>(data: Data?, response: Response<T>, completion: @escaping (Result<T,Error>) -> Void) {
        completion(
            Result {
                guard let data = data else {
                    throw ErrorAPI.notDataFound
                }
                if let dataParsed = try? response.content(data) {
                    return dataParsed
                } else {
                    throw ErrorAPI.unableParse
                }
            }
        )
    }
}
