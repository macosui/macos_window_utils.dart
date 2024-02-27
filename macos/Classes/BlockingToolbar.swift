//
//  BlockingToolbar.swift
//  macos_window_utils
//
//  Created by Ben Hagen on 12.11.2023.
//

import Foundation
import FlutterMacOS

class BlockingToolbar: NSToolbar, NSToolbarDelegate {
  let flutterView: FlutterViewController

  init(flutterView: FlutterViewController) {
      self.flutterView = flutterView
      super.init(identifier: "BlockingToolbar")
  }

  func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    [.flexibleSpace, NSToolbarItem.Identifier("BlockingItem")]
  }

  func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
    toolbarDefaultItemIdentifiers(toolbar)
  }

  func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
    if itemIdentifier == NSToolbarItem.Identifier("BlockingItem") {
      let item = NSToolbarItem(itemIdentifier: itemIdentifier)
      let view = ForwardingView()
      view.flutterView = flutterView
      view.widthAnchor.constraint(lessThanOrEqualToConstant: 100000).isActive = true
      view.widthAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
      item.view = view
      return item
    }
    return nil
  }
}


class ForwardingView: NSView {
  var flutterView: FlutterViewController?

  override func mouseDown(with event: NSEvent) {
    flutterView!.mouseDown(with: event)
  }

  override func mouseUp(with event: NSEvent) {
    flutterView!.mouseUp(with: event)
  }
}
