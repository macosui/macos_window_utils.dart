//
//  ButtonTypeNameToButtonTypeConverter.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 05.09.23.
//

import Foundation
import AppKit

class ButtonTypeNameToButtonTypeConverter {
    public static func getButtonTypeFromName(name: String) -> NSWindow.ButtonType? {
        switch (name) {
        case "closeButton":
            return NSWindow.ButtonType.closeButton
            
        case "documentIconButton":
            return NSWindow.ButtonType.documentIconButton
            
        case "documentVersionsButton":
            return NSWindow.ButtonType.documentVersionsButton
            
        case "miniaturizeButton":
            return NSWindow.ButtonType.miniaturizeButton
            
        case "toolbarButton":
            return NSWindow.ButtonType.toolbarButton
            
        case "zoomButton":
            return NSWindow.ButtonType.zoomButton
        
        default:
            return nil
        }
    }
}
