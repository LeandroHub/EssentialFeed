//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Leandro Fournier on 7/27/23.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
