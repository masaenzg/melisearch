//
//  Error+Extension.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 28/01/21.
//  Copyright © 2021 msaenz. All rights reserved.
//

import UIKit

extension Error {
    func alert(with controller: UIViewController,
               completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: String(), message: "\(self)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: completion)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
