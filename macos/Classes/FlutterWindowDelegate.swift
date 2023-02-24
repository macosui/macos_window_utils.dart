//
//  FlutterWindowDelegate.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 24.02.23.
//

import Foundation

class FlutterWindowDelegate: NSObject, NSWindowDelegate {
    public static func create(window: NSWindow) -> FlutterWindowDelegate {
        let newDelegate = FlutterWindowDelegate()
        window.delegate = newDelegate
        return newDelegate
    }
}
