//
//  SideMenuView.swift
//  Editor
//
//  Created by Aleksandr Grebnev1 on 02.07.2022.
//

import Foundation
import AppKit

class SideMenuView: NSView {
    @IBOutlet weak var controlsCollectionView: NSCollectionView!

    func onDataUpdate() {
        controlsCollectionView.reloadData()
    }
}
