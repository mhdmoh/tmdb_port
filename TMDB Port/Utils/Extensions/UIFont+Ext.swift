//
//  UIFont+Ext.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 10..
//

import UIKit

extension UIFont {
    func bold() -> UIFont {
        return withTraits(.traitBold)
    }
    
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }
}
