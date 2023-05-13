//
//  GradientView.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 22/11/2022.
//

import Foundation
import UIKit

class GradientView: UIView {

    override class var layerClass: AnyClass { CAGradientLayer.self }

    // MARK: - PRIVATE
    // MARK: IBInspectables
    @IBInspectable private var firstColor: UIColor = UIColor.clear { didSet { updateView() } }
    @IBInspectable private var secondColor: UIColor = UIColor.black { didSet { updateView() } }
    @IBInspectable private var opacity: Float = 1.0 { didSet { updateView() } }



    // MARK: Methods
    //Updates the GradientView's layer with the firstColor, the secondColr and the opacity
    private func updateView() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        alpha = CGFloat(opacity)
    }
}
