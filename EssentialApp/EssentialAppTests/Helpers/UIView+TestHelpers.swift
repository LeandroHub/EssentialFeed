//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Leandro Fournier on 8/10/23.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.main.run(until: Date())
    }
}
