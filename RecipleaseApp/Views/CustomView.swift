//
//  CustomView.swift
//  RecipleaseApp
//
//  Created by Richard Arif Mazid on 01/10/2022.
//

import Foundation
import UIKit

class CustomView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        addCornerRadius()
    }

    private func addCornerRadius() {
        layer.cornerRadius = 6
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
    }
}
