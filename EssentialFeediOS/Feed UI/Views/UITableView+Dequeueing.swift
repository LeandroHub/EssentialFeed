//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Leandro Fournier on 7/18/23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
