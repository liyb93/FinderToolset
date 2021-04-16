//
//  File Name:  AppDelegate.swift
//  Product Name:   FinderToolset
//  Created Date:   2021/4/6 17:46
//

import Cocoa
import ServiceManagement

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    fileprivate var statusItem: NSStatusItem!
    fileprivate var preferences: GeneralController = GeneralController.init()
    fileprivate lazy var menu: NSMenu = {
        let menu = NSMenu.init(title: "菜单")
        let launch = NSMenuItem.init(title: "开机自启", action: #selector(onClickLaunch(_:)), keyEquivalent: "")
        if UserDefaults.standard.bool(forKey: Key.launch) {
            launch.state = .on
        } else {
            launch.state = .off
        }
        menu.addItem(NSMenuItem.separator())
        menu.addItem(launch)
        let preferences = NSMenuItem.init(title: "偏好设置", action: #selector(onClickPreferences), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(preferences)
        let instructions = NSMenuItem.init(title: "使用说明", action: #selector(onClickInstructions), keyEquivalent: "")
        menu.addItem(instructions)
        let about = NSMenuItem.init(title: "关于我们", action: #selector(onClickAbout), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(about)
        let exit = NSMenuItem.init(title: "退出", action: #selector(onClickExit), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(exit)
        return menu
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusBar()
        
        let user = UserDefaults.init(suiteName: "group.com.liyb.FinderToolset")
        if user?.object(forKey: Key.appIcon) == nil {
            user?.setValue(["0","1","2","3","4","5"], forKey: Key.appIcon)
        }
        if user?.object(forKey: Key.cutIcon) == nil {
            user?.setValue("20.0", forKey: Key.cutIcon)
        }
        if user?.object(forKey: Key.moveTrash) == nil {
            user?.setValue(true, forKey: Key.moveTrash)
        }
        
        
        
    }
    
    fileprivate func setupStatusBar() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let icon = NSImage.init(named: "status")
        icon?.isTemplate = false
        if #available(macOS 10.14, *) {
            statusItem.button?.image = icon
        } else {
            statusItem.image = icon
        }
        statusItem.menu = menu
    }
    
    @objc fileprivate func onClickLaunch(_ item: NSMenuItem) {
        if item.state == .off {
            item.state = .on
        } else {
            item.state = .off
        }
        UserDefaults.standard.setValue(item.state == .on ? true : false, forKey: Key.launch)
        let success = SMLoginItemSetEnabled(Key.helperBundleIdentifier as CFString, item.state == .on ? true : false)
        if success {
            print("启动项配置成功: ", item.state == .on ? true : false)
        } else {
            print("启动项配置失败")
        }
    }
    
    @objc fileprivate func onClickPreferences() {
        preferences.show()
    }
    
    @objc fileprivate func onClickInstructions() {
        guard let url = URL.init(string: "https://github.com/liyb93/FinderToolset") else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @objc fileprivate func onClickAbout() {
        NSApp.orderFrontStandardAboutPanel(nil)
    }
    
    @objc fileprivate func onClickExit() {
        NSApp.terminate(nil)
    }
}

extension AppDelegate {
    struct Key {
        static let launch = "FinderToolset.launch.key"
        static let appIcon = "FinderToolset.preferences.appIcon.key"
        static let cutIcon = "FinderToolset.preferences.cutIcon.key"
        static let moveTrash = "FinderToolset.preferences.moveTrash.key"
        static let helperBundleIdentifier = "com.liyb.FinderToolsetHelper"
    }
}
