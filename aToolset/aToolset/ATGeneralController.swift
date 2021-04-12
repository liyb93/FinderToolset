//
//  File Name:  ATGeneralController.swift
//  Product Name:   Toolset
//  Created Date:   2021/4/7 17:28
//

import Cocoa
import Preferences

class ATGeneralController: PreferencesWindowController {
    
    init() {
        let panes: [PreferencePane] = [
            ATPreferencesController(),
        ]
        super.init(preferencePanes: panes, style: .toolbarItems, animated: true, hidesToolbarForSingleItem: true)
        window?.delegate = self
    }
    
    override func show(preferencePane preferenceIdentifier: PreferencePaneIdentifier? = nil) {
        super.show(preferencePane: preferenceIdentifier)
        NSApp.setActivationPolicy(.regular)
    }
}

extension ATGeneralController: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)
    }
}
