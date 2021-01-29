//
//  UIImageView+Extension.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 23/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL, errorClosure: ((Error?) -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorClosure?(error)
                }
            }
        }
    }
}
