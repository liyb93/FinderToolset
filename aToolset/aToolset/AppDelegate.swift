//
//  File Name:  AppDelegate.swift
//  Product Name:   
//  Created Date:   2021/4/6 17:46
//

import Cocoa
import ServiceManagement

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private lazy var menu: NSMenu = {
        let menu = NSMenu.init(title: "菜单")
        let launch = NSMenuItem.init(title: "开机自启", action: #selector(onClickLaunch(_:)), keyEquivalent: "")
        if UserDefaults.standard.bool(forKey: Key.launchKey) {
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
    }
    
    private func setupStatusBar() {
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
    
    @objc private func onClickLaunch(_ item: NSMenuItem) {
        if item.state == .off {
            item.state = .on
        } else {
            item.state = .off
        }
        UserDefaults.standard.setValue(item.state == .on ? true : false, forKey: Key.launchKey)
        let success = SMLoginItemSetEnabled(Key.helperBundleIdentifier as CFString, item.state == .on ? true : false)
        if success {
            print("启动项配置成功: ", item.state == .on ? true : false)
        } else {
            print("启动项配置失败")
        }
    }
    
    @objc private func onClickPreferences() {
        print("偏好设置")
    }
    
    @objc private func onClickInstructions() {
        
    }
    
    @objc private func onClickAbout() {
        NSApp.orderFrontStandardAboutPanel(nil)
    }
    
    @objc private func onClickExit() {
        NSApp.terminate(nil)
    }
}

extension AppDelegate {
    fileprivate struct Key {
        static let launchKey = "aToolset.launch.key"
        static let helperBundleIdentifier = "com.liyb.aToolsetHelper"
    }
}
