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
        return menu
    }
    
    @IBAction func toPlistAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        for item in items {
            LYBFileTools.plist(withInputPath: item.path, outPath: target?.path ?? "/Users/liyb/Desktop")
        }
    }
    
    @IBAction func toJsonAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []

        for item in items {
            LYBFileTools.json(withInputPath: item.path, outPath: target?.path ?? "/Users/liyb/Desktop")
        }
    }
    
    @IBAction func toXmlAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        for item in items {
            LYBFileTools.xml(withInputPath: item.path, outPath: target?.path ?? "/Users/liyb/Desktop")
        }
    }
    
    @IBAction func cutAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        for item in items {
            LYBImageTools.imageTools(withInputPath: item.path, outPath: target?.path ?? "/Users/liyb/Desktop", radius: 50)
        }
    }
    
    @IBAction func generateAction(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        
        for item in items {
            LYBImageTools.imageToolsMakeIcon(with: item.path, outPath: target?.path ?? "/Users/liyb/Desktop", types: "[2]")
        }
    }
}

