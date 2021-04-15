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
    }
    
    // MARK: - Menu and toolbar item support
    override var toolbarItemName: String {
        return "aToolset"
    }
    
    override var toolbarItemToolTip: String {
        return "aToolset: 单击菜单的工具栏项。"
    }
    
    override var toolbarItemImage: NSImage {
        return NSImage(named: "status")!
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "")
        let file = NSMenuItem.init(title: "新建文件", action: nil, keyEquivalent: "")
        file.image = NSImage.init(named: "newFile")
        file.submenu = NSMenu.init(title: "file")
        file.submenu?.addItem(.init(title: "TXT", action: #selector(createTxtFile(_:)), keyEquivalent: ""))
        file.submenu?.addItem(.init(title: "RTF", action: #selector(createRtfFile(_:)), keyEquivalent: ""))
        file.submenu?.addItem(.init(title: "Plist", action: #selector(createPlistFile(_:)), keyEquivalent: ""))
        file.submenu?.addItem(.init(title: "Markdown", action: #selector(createMarkdownFile(_:)), keyEquivalent: ""))
        menu.addItem(file)
        let clean = NSMenuItem.init(title: "清理XCode", action: #selector(cleanXCodeAction(_:)), keyEquivalent: "")
        clean.image = NSImage.init(named: "clean")
        menu.addItem(clean)
        let copy = NSMenuItem.init(title: "拷贝路径", action: #selector(copyCurrentPath(_:)), keyEquivalent: "")
        copy.image = NSImage.init(named: "copy")
        menu.addItem(copy)
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
        
        let user = UserDefaults.init(suiteName: "group.com.liyb.Toolset")
        let moveTrash = user?.bool(forKey: Key.moveTrash) ?? true
        
        if moveTrash {
            NSPasteboard.general.clearContents()
            let trashPath = (library as NSString).substring(to: range.location) + ".Trash"
            if FileManager.default.fileExists(atPath: archive) {
                try? FileManager.default.moveItem(atPath: archive, toPath: trashPath + "/Archives")
            }
            if FileManager.default.fileExists(atPath: data) {
                try? FileManager.default.moveItem(atPath: data, toPath: trashPath + "/DerivedData")
            }
        } else {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString("移除", forType: .string)
            if FileManager.default.fileExists(atPath: archive) {
                try? FileManager.default.removeItem(atPath: archive)
            }
            if FileManager.default.fileExists(atPath: data) {
                try? FileManager.default.removeItem(atPath: data)
            }
        }
    }
    
    @IBAction func createTxtFile(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        guard let targetPath = target?.path else {
            return
        }
        var path = targetPath.appending("/未命名.txt")
        var count = 1
        while FileManager.default.fileExists(atPath: path) {
            count += 1
            path = targetPath.appending("/未命名 \(count).txt")
        }
        let result = FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        if result {
            NSWorkspace.shared.open(URL.init(fileURLWithPath: path))
        }
    }
    
    @IBAction func createRtfFile(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        guard let targetPath = target?.path else {
            return
        }
        var path = targetPath.appending("/未命名.rtf")
        var count = 1
        while FileManager.default.fileExists(atPath: path) {
            count += 1
            path = targetPath.appending("/未命名 \(count).rtf")
        }
        let result = FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        if result {
            NSWorkspace.shared.open(URL.init(fileURLWithPath: path))
        }
    }
    
    @IBAction func createPlistFile(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        guard let targetPath = target?.path else {
            return
        }
        var path = targetPath.appending("/未命名.plist")
        var count = 1
        while FileManager.default.fileExists(atPath: path) {
            count += 1
            path = targetPath.appending("/未命名 \(count).plist")
        }
        let dict = NSDictionary.init()
        let result = dict.write(toFile: path, atomically: true)
        if result {
            NSWorkspace.shared.open(URL.init(fileURLWithPath: path))
        }
    }
    
    @IBAction func createMarkdownFile(_ sender: AnyObject?) {
        let target = FIFinderSyncController.default().targetedURL()
        guard let targetPath = target?.path else {
            return
        }
        var path = targetPath.appending("/未命名.md")
        var count = 1
        while FileManager.default.fileExists(atPath: path) {
            count += 1
            path = targetPath.appending("/未命名 \(count).md")
        }
        let result = FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        if result {
            NSWorkspace.shared.open(URL.init(fileURLWithPath: path))
        }
    }
    
    @IBAction func copyCurrentPath(_ sender: AnyObject?) {
        let items = FIFinderSyncController.default().selectedItemURLs() ?? []
        let target = FIFinderSyncController.default().targetedURL()
        var path = target?.path
        if items.count > 0 {
            path = ""
            for item in items {
                path?.append("\(item.path)\n")
            }
        }
        guard let p = path else {
            return
        }
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(p, forType: .string)
    }
}

extension FinderSync {
    struct Key {
        static let appIcon = "aToolset.preferences.appIcon.key"
        static let cutIcon = "aToolset.preferences.cutIcon.key"
        static let moveTrash = "aToolset.preferences.moveTrash.key"
    }
}
