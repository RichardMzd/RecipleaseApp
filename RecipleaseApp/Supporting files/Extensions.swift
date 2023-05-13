//
//  Ingredients.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 14/11/2022.
//

import Foundation
import UIKit


extension UIViewController {
    
    //method to detect error in API Call request
    func alertServerAccess(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
    static let greenRecipe: UIColor = UIColor(named: "greenRecipe")!
}

extension UIImageView {
    // Download a image with an URL
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

extension Int {
    // Convert the minutes to display in the better string format
    var convertInt: String {
        if self == 0 {
            let timeNull = "N/A"
            return timeNull
        } else {
            let minutes = self % 60
            let hours = self / 60
            let timeFormatString = String(format: "%01dh%02d", hours, minutes)
            let timeFormatStringMin = String(format: "%02dm", minutes)
            let timeFormatNoMin = String(format: "%01dh", hours)
            let timeFormatStringLessTenMin = String(format: "%01dm", minutes)
            if self < 60 {
                if minutes < 10 {
                    return timeFormatStringLessTenMin
                }
                return timeFormatStringMin
            } else if minutes == 0 {
                return timeFormatNoMin
            } else {
                return timeFormatString
            }
        }
    }
}

