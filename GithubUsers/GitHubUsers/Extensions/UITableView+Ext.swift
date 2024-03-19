//
//  UITableView+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/14/24.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
