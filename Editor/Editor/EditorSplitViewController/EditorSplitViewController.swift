//
//  EditorSplitViewController.swift
//  Editor
//
//  Created by Aleksandr Grebnev1 on 02.07.2022.
//

import Foundation
import AppKit
import Document

public class EditorSplitViewController: NSSplitViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func configure(leftMenu leftMenuVC: NSViewController, detailsVC: NSViewController) {
        leftMenuVC.view.widthAnchor.constraint(equalToConstant: Const.sideMenuWidth).isActive = true
        let sideMenu = NSSplitViewItem(viewController: leftMenuVC)
        sideMenu.canCollapse = true
        sideMenu.holdingPriority = .defaultHigh
        addSplitViewItem(sideMenu)
        addSplitViewItem(NSSplitViewItem(viewController: detailsVC))
    }

    private func setupUI() {
       splitView.dividerStyle = .paneSplitter
    }

    private enum Const {
        static let sideMenuWidth: CGFloat = 200
    }
}

public extension EditorSplitViewController {
    static func instantiate(with document: VODesignDocument) -> EditorSplitViewController {
        let editorSplitVC = EditorSplitViewController()
        let sideMenuVC = SideMenuViewController.fromStoryboard()
        let editorVC = EditorViewController.fromStoryboard()
        editorVC.presenter.document = document
        editorSplitVC.configure(leftMenu: sideMenuVC, detailsVC: editorVC)

        return editorSplitVC
    }
}
