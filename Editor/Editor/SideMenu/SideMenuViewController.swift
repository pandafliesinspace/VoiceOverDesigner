//
//  SideMenuViewController.swift
//  Editor
//
//  Created by Aleksandr Grebnev1 on 02.07.2022.
//

import Foundation
import AppKit

class SideMenuViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer?.backgroundColor = NSColor.red.cgColor
    }
    
    public static func fromStoryboard() -> SideMenuViewController {
        let storyboard = NSStoryboard(name: "SideMenu", bundle: Bundle(for: SideMenuViewController.self))
        return storyboard.instantiateInitialController() as! SideMenuViewController
    }
}
