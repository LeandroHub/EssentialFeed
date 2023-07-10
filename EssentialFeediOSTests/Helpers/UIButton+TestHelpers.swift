//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Leandro Fournier on 7/10/23.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
