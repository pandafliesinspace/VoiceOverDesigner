//
//  SideMenuItem.swift
//  Editor
//
//  Created by Aleksandr Grebnev1 on 02.07.2022.
//

import Cocoa

class SideMenuItem: NSCollectionViewItem {
    static let reuseId = NSUserInterfaceItemIdentifier(rawValue: "SideMenuItem")

    @IBOutlet private weak var weightLabel: NSTextField!
    @IBOutlet private weak var titleLabel: NSTextField!

    var itemTitle: String = "" {
        didSet {
            titleLabel.stringValue = itemTitle
        }
    }

    var itemWeight: Int = 0 {
        didSet {
            weightLabel.stringValue = "\(itemWeight + 1)."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

private extension SideMenuItem {
    func configureUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGray.withAlphaComponent(0.3).cgColor
        view.layer?.cornerRadius = 3
        titleLabel.textColor = NSColor.black
        titleLabel.font = NSFont.systemFont(ofSize: 14)
        weightLabel.textColor = NSColor.black
        weightLabel.font = NSFont.systemFont(ofSize: 14, weight: .bold)
    }
}
