//
//  PassthroughViewHandler.swift
//  macos_window_utils
//
//  Created by Adrian Samoticha on 22.12.24.
//

import Foundation

import FlutterMacOS

class PassthroughViewHandler {
  private var mainFlutterWindow: NSWindow?
  private var toolbarPassthroughContainer: NSView?
  private var toolbarPassthroughViews: [String: PassthroughView] = [:]
  
  static func create() -> PassthroughViewHandler {
    return PassthroughViewHandler();
  }
  
  func start(mainFlutterWindow: NSWindow) {
    self.mainFlutterWindow = mainFlutterWindow
    
    // Clean up necessary for flutter hot restart
    for entry in self.toolbarPassthroughViews {
      self.removeToolbarPassthroughView(id: entry.key)
    }
    self.toolbarPassthroughViews.removeAll()
    self.toolbarPassthroughContainer = nil
    
    // Get the count of accessory view controllers
    let accessoryCount = mainFlutterWindow.titlebarAccessoryViewControllers.count
    
    // Iterate through the indices in reverse order to avoid index shifting
    for index in stride(from: accessoryCount - 1, through: 0, by: -1) {
      mainFlutterWindow.removeTitlebarAccessoryViewController(at: index)
    }
  }
  
  func updateToolbarPassthroughView(id: String, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, enableDebugLayers: Bool, flutterViewController: NSViewController) {
    assert(mainFlutterWindow != nil)
    
    DispatchQueue.main.async {
      let window = self.mainFlutterWindow!
      
      if self.toolbarPassthroughContainer == nil {
        // Initialize the view if it is nil
        let accessoryViewController = NSTitlebarAccessoryViewController()
        accessoryViewController.layoutAttribute = .top
        
        self.toolbarPassthroughContainer = NSView()
        if (enableDebugLayers) {
          self.toolbarPassthroughContainer!.wantsLayer = true
          self.toolbarPassthroughContainer!.layer?.backgroundColor = NSColor.yellow.withAlphaComponent(0.2).cgColor
        }
        self.toolbarPassthroughContainer!.translatesAutoresizingMaskIntoConstraints = false
        
        // Assign the custom view to the accessory view controller
        accessoryViewController.view = self.toolbarPassthroughContainer!
        
        // Add the accessory view controller to the window
        window.addTitlebarAccessoryViewController(accessoryViewController)
      }
      
      if let containerView = self.toolbarPassthroughContainer {
        let windowHeight = window.frame.height
        
        // Convert Flutter coordinates to macOS coordinates
        let macY = windowHeight - y - height
        
        let flutterToggleInvertedPosition = CGRect(x: x, y: macY, width: width, height: height)
        let frame = containerView.convert(flutterToggleInvertedPosition, from: nil)
        
        var view: PassthroughView
        if let existingView = self.toolbarPassthroughViews[id] {
          view = existingView
          view.frame = frame
        } else {
          view = PassthroughView(frame: frame, flutterViewController:flutterViewController)
          if (enableDebugLayers) {
            view.wantsLayer = true
            view.layer?.backgroundColor = NSColor.green.withAlphaComponent(0.2).cgColor
            
          }
          
          // Add the view to the containerView
          containerView.addSubview(view)
          self.toolbarPassthroughViews[id] = view
        }
      }
    }
  }
  
  func removeToolbarPassthroughView(id: String) {
    DispatchQueue.main.async {
      if let view = self.toolbarPassthroughViews[id] {
        view.removeFromSuperview()
        self.toolbarPassthroughViews.removeValue(forKey: id)
      }
    }
  }
}

class PassthroughView: NSView {
  var flutterViewController: NSViewController?
  
  required init(frame: CGRect, flutterViewController: NSViewController) {
    super.init(frame: frame)
    self.flutterViewController = flutterViewController
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func mouseDown(with event: NSEvent) {
    // `mouseDownCanMoveWindow` has no effect when the NSWindow’s
    // `titlebarAppearsTransparent` property is true. For this reason
    // it is necessary to temporarily make the window immovable when
    // the passthrough view is clicked.
    let oldIsMovableValue = window!.isMovable
    window!.isMovable = false
    defer {
      window!.isMovable = oldIsMovableValue
    }
    
    flutterViewController!.mouseDown(with: event)
  }
  
  override func mouseUp(with event: NSEvent) {
    flutterViewController!.mouseUp(with: event)
  }
  
  override func rightMouseUp(with event: NSEvent) {
    flutterViewController!.rightMouseUp(with: event)
  }
  
  override func rightMouseDown(with event: NSEvent) {
    flutterViewController!.rightMouseDown(with: event)
  }
  
  override var mouseDownCanMoveWindow: Bool {
    return false
  }
}
