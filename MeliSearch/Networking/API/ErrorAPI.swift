//
//  ErrorAPI.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 21/01/21.
//  Copyright © 2021 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import Foundation

enum ErrorAPI: Error {
    case internetConnectionFailed
    case notDataFound
    case unableParse
}

extension ErrorAPI: CustomStringConvertible {
    var description: String {
        return "No es posible mostrar la informacion en este momento"
    }
}
