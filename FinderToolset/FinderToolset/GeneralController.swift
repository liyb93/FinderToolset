//
//  File Name:  GeneralController.swift
//  Product Name:   FinderToolset
//  Created Date:   2021/4/7 17:28
//

import Cocoa
import Preferences

class GeneralController: PreferencesWindowController {
    
    init() {
        let panes: [PreferencePane] = [
            PreferencesController(),
        ]
        super.init(preferencePanes: panes, style: .toolbarItems, animated: true, hidesToolbarForSingleItem: true)
        window?.delegate = self
    }
    
    override func show(preferencePane preferenceIdentifier: PreferencePaneIdentifier? = nil) {
        super.show(preferencePane: preferenceIdentifier)
        NSApp.setActivationPolicy(.regular)
    }
}

extension GeneralController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
    }
}
