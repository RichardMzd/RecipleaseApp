//
//  VoiceOver.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 07/03/2023.
//

import Foundation

class VoiceOver {
    
    static let shared = VoiceOver()
    private init() {}
    
    func voiceOver(object: NSObject, hint: String) {
        object.isAccessibilityElement = true
        object.accessibilityLabel = hint
    }
}

