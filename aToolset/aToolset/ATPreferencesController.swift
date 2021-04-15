//
//  File Name:  ATPreferencesController.swift
//  Product Name:   Toolset
//  Created Date:   2021/4/7 17:30
//

import Cocoa
import Preferences

class ATPreferencesController: NSViewController, PreferencePane {
    let preferencePaneIdentifier = Identifier.init("aToolset.general")
    let preferencePaneTitle = "通用"
    let toolbarItemIcon = NSImage.init(named: "general")!
    
    override var nibName: NSNib.Name? { "ATPreferencesController" }
    
    @IBOutlet weak var moveTrashButton: NSButton!
    @IBOutlet weak var cutComboBox: NSComboBox!
    @IBOutlet weak var iPhoneButton: NSButton!
    @IBOutlet weak var iPadButton: NSButton!
    @IBOutlet weak var macButton: NSButton!
    @IBOutlet weak var carPlayButton: NSButton!
    @IBOutlet weak var watchButton: NSButton!
    @IBOutlet weak var androidButton: NSButton!
    
    fileprivate var appIcon: [String] = []
    fileprivate var cutIcon: String = "20.0"
    fileprivate var moveTrash: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        appIcon = user?.object(forKey: AppDelegate.Key.appIcon) as? [String] ?? ["0","1","2","3","4","5"]
        cutIcon = user?.object(forKey: AppDelegate.Key.cutIcon) as? String ?? "20.0"
        moveTrash = user?.bool(forKey: AppDelegate.Key.moveTrash) ?? true
        
        cutComboBox.stringValue = cutIcon
        iPhoneButton.state = appIcon.contains("0") ? .on : .off
        iPadButton.state = appIcon.contains("1") ? .on : .off
        macButton.state = appIcon.contains("2") ? .on : .off
        carPlayButton.state = appIcon.contains("3") ? .on : .off
        watchButton.state = appIcon.contains("4") ? .on : .off
        androidButton.state = appIcon.contains("5") ? .on : .off
        
        moveTrashButton.state = moveTrash ? .on : .off
        
        cutComboBox.window?.makeFirstResponder(nil)
    }
    
    override func mouseDown(with event: NSEvent) {
        cutComboBox.window?.makeFirstResponder(nil)
    }
    
    @IBAction func onCutAction(_ sender: NSComboBox) {
        let cut = sender.stringValue
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(cut, forKey: AppDelegate.Key.cutIcon)
        print("修改后: \(cut)")
    }
    
    @IBAction func onIphoneAction(_ sender: NSButton) {
        if sender.state == .off {
            guard let index = appIcon.firstIndex(of: "0") else {
                return
            }
            appIcon.remove(at: index)
        } else {
            if appIcon.contains("0") {
                return
            }
            appIcon.append("0")
        }
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(appIcon, forKey: AppDelegate.Key.appIcon)
        print("修改后: \(appIcon)")
    }
    
    @IBAction func onIpadAction(_ sender: NSButton) {
        if sender.state == .off {
            guard let index = appIcon.firstIndex(of: "1") else {
                return
            }
            appIcon.remove(at: index)
        } else {
            if appIcon.contains("1") {
                return
            }
            appIcon.append("1")
        }
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(appIcon, forKey: AppDelegate.Key.appIcon)
        print("修改后: \(appIcon)")
    }
    
    @IBAction func onMacAction(_ sender: NSButton) {
        if sender.state == .off {
            guard let index = appIcon.firstIndex(of: "2") else {
                return
            }
            appIcon.remove(at: index)
        } else {
            if appIcon.contains("2") {
                return
            }
            appIcon.append("2")
        }
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(appIcon, forKey: AppDelegate.Key.appIcon)
        print("修改后: \(appIcon)")
    }
    
    @IBAction func onCarplayAction(_ sender: NSButton) {
        if sender.state == .off {
            guard let index = appIcon.firstIndex(of: "3") else {
                return
            }
            appIcon.remove(at: index)
        } else {
            if appIcon.contains("3") {
                return
            }
            appIcon.append("3")
        }
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(appIcon, forKey: AppDelegate.Key.appIcon)
        print("修改后: \(appIcon)")
    }
    
    @IBAction func onWatchAction(_ sender: NSButton) {
        if sender.state == .off {
            guard let index = appIcon.firstIndex(of: "4") else {
                return
            }
            appIcon.remove(at: index)
        } else {
            if appIcon.contains("4") {
                return
            }
            appIcon.append("4")
        }
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(appIcon, forKey: AppDelegate.Key.appIcon)
        print("修改后: \(appIcon)")
    }
    
    @IBAction func onAndroidAction(_ sender: NSButton) {
        if sender.state == .off {
            guard let index = appIcon.firstIndex(of: "5") else {
                return
            }
            appIcon.remove(at: index)
        } else {
            if appIcon.contains("5") {
                return
            }
            appIcon.append("5")
        }
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(appIcon, forKey: AppDelegate.Key.appIcon)
        print("修改后: \(appIcon)")
    }
    
    @IBAction func onTrashAction(_ sender: NSButton) {
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        user?.setValue(sender.state == .on ? true : false, forKey: AppDelegate.Key.moveTrash)
    }
}

extension ATPreferencesController {
    fileprivate struct Key {
        static let preference = "aToolset.preference"
    }
}
