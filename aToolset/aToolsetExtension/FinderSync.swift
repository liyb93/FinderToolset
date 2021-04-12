//
//  File Name:  FinderSync.swift
//  Product Name:   ToolsetExtension
//  Created Date:   2021/4/6 17:48
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    var myFolderURL = URL(fileURLWithPath: "/")
    
    override init() {
        super.init()
        FIFinderSyncController.default().directoryURLs = [self.myFolderURL]
        
        FIFinderSyncController.default().setBadgeImage(NSImage(named: NSImage.colorPanelName)!, label: "Status One" , forBadgeIdentifier: "One")
        FIFinderSyncController.default().setBadgeImage(NSImage(named: NSImage.cautionName)!, label: "Status Two", forBadgeIdentifier: "Two")
        
    }
    
    // MARK: - Primary Finder Sync protocol methods
    override func requestBadgeIdentifier(for url: URL) {
        let whichBadge = abs(url.path.hash) % 3
        let badgeIdentifier = ["", "One", "Two"][whichBadge]
        FIFinderSyncController.default().setBadgeIdentifier(badgeIdentifier, for: url)
    }
    
    // MARK: - Menu and toolbar item support
    override var toolbarItemName: String {
        return "aToolset"
    }
    
    override var toolbarItemToolTip: String {
        return "aToolset: 单击菜单的工具栏项。"
    }
    
    override var toolbarItemImage: NSImage {
        return NSImage(named: NSImage.cautionName)!
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "")
        let plist = NSMenuItem.init(title: "转plist", action: #selector(toPlistAction(_:)), keyEquivalent: "")
        plist.image = NSImage.init(named: "plist")
        menu.addItem(plist)
        let json = NSMenuItem.init(title: "转json", action: #selector(toJsonAction(_:)), keyEquivalent: "")
        json.image = NSImage.init(named: "json")
        menu.addItem(json)
        let xml = NSMenuItem.init(title: "转xml", action: #selector(toXmlAction(_:)), keyEquivalent: "")
        xml.image = NSImage.init(named: "xml")
        menu.addItem(xml)
        let cut = NSMenuItem.init(title: "切圆角", action: #selector(cutAction(_:)), keyEquivalent: "")
        cut.image = NSImage.init(named: "cut")
        menu.addItem(cut)
        let app = NSMenuItem.init(title: "生成App图标", action: #selector(generateAction(_:)), keyEquivalent: "")
        app.image = NSImage.init(named: "app")
        menu.addItem(app)
        let clean = NSMenuItem.init(title: "清理XCode", action: #selector(cleanXCodeAction(_:)), keyEquivalent: "")
        clean.image = NSImage.init(named: "clean")
        menu.addItem(clean)
        return menu
    }
    
    @IBAction func toPlistAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        guard let path = target?.path else {
            return
        }
        
        for item in items {
            LYBFileTools.plist(withInputPath: item.path, outPath: path)
        }
    }
    
    @IBAction func toJsonAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []

        guard let path = target?.path else {
            return
        }
        
        for item in items {
            LYBFileTools.json(withInputPath: item.path, outPath: path)
        }
    }
    
    @IBAction func toXmlAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        guard let path = target?.path else {
            return
        }
        
        for item in items {
            LYBFileTools.xml(withInputPath: item.path, outPath: path)
        }
    }
    
    @IBAction func cutAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        let cutIcon = user?.object(forKey: Key.cutIcon) as? String
        let cut = Double(cutIcon ?? "20.0") ?? 20.0
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("cut: \(cut)", forType: .string)
        
        guard let path = target?.path else {
            return
        }
        
        for item in items {
            LYBImageTools.imageTools(withInputPath: item.path, outPath: path, radius: CGFloat(cut))
        }
    }
    
    @IBAction func generateAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        let app = user?.object(forKey: Key.appIcon) as? [String] ?? ["0","1","2","3","4","5"]
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString("app: \(app)", forType: .string)
        
        guard let data = try? JSONSerialization.data(withJSONObject: app, options: .fragmentsAllowed), let types = String.init(data: data, encoding: .utf8), let path = target?.path else {
            return
        }
        for item in items {
            LYBImageTools.imageToolsMakeIcon(with: item.path, outPath: path, types: types)
        }
    }
    
    @IBAction func cleanXCodeAction(_ sender: AnyObject?) {
        let path = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)[0] as NSString
        let range = path.range(of: "Library")
        let library = path.substring(to: range.location + range.length)
        
        let xcode = library.appending("/Developer/Xcode/")
        
        let archive = xcode.appending("/Archives")
        let data = xcode.appending("/DerivedData")
        
        if FileManager.default.fileExists(atPath: archive) {
            try? FileManager.default.removeItem(atPath: archive)
        }
        if FileManager.default.fileExists(atPath: data) {
            try? FileManager.default.removeItem(atPath: data)
        }
    }
}

extension FinderSync {
    struct Key {
        static let appIcon = "aToolset.preferences.appIcon.key"
        static let cutIcon = "aToolset.preferences.cutIcon.key"
    }
}
