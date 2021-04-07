//
//  File Name:  AppDelegate.swift
//  Product Name:   
//  Created Date:   2021/4/7 15:56
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // 启动主程序
        var compoents = (Bundle.main.bundlePath as NSString).pathComponents
        if compoents.count > 4 {
            compoents = (compoents as NSArray).subarray(with: NSRange.init(location: 0, length: compoents.count-4)) as? [String] ?? []
            let path = NSString.path(withComponents: compoents)
            NSWorkspace.shared.launchApplication(path)
            NSApp.terminate(nil)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

