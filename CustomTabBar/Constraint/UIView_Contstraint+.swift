//
//  UIView_Contstraint+.swift
//  CustomTabBar
//
//  Created by JunHwan Kim on 2023/03/26.
//

import UIKit

extension UIView {
    func constraintIsEqualSuperView(view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
