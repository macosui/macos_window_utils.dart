//
//  colorFromRGBAString.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 31.10.24.
//

import Foundation

import Cocoa

extension NSColor {
    // Function to convert an RGBA string like "255,0,0,128" into NSColor
    class func colorFromRGBAString(_ rgbaString: String) -> NSColor? {
        let components = rgbaString.split(separator: ",").map { String($0) }
        
        guard components.count == 4,
              let red = Double(components[0]),
              let green = Double(components[1]),
              let blue = Double(components[2]),
              let alpha = Double(components[3]) else {
            return nil // Return nil if input is invalid
        }
        
        return NSColor(red: CGFloat(red / 255.0),
                       green: CGFloat(green / 255.0),
                       blue: CGFloat(blue / 255.0),
                       alpha: CGFloat(alpha / 255.0))
    }
}
