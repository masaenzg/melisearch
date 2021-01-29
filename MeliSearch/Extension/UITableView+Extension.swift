//
//  UITableView+Extension.swift
//  MeliSearch
//
//  Created by Manuel Adolfo Saenz Grijalba on 21/01/21.
//  Copyright © 2021 Manuel Adolfo Saenz Grijalba. All rights reserved.
//

import UIKit

extension UITableView {
    func registerUINib(nibName: String, bundle: Bundle = .main) {
        register(UINib(nibName: nibName, bundle: bundle),
                 forCellReuseIdentifier: nibName)
    }
}
