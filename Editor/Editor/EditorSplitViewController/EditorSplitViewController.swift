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

    public static func instantiate(with document: VODesignDocument) -> EditorSplitViewController {
        let editorSplitVC = EditorSplitViewController()
        let sideMenuVC = SideMenuViewController.fromStoryboard()
        let editorVC = EditorViewController.fromStoryboard()

        editorVC.presenter.document = document
        editorVC.presenter.editorDelegate = sideMenuVC.presenter
        sideMenuVC.presenter.sideMenuDelegate = editorVC.presenter
        editorSplitVC.configure(leftMenu: sideMenuVC, detailsVC: editorVC)

        return editorSplitVC
    }
}


private extension EditorSplitViewController {
    func configure(leftMenu leftMenuVC: NSViewController, detailsVC: NSViewController) {
        let sideMenu = NSSplitViewItem(contentListWithViewController: leftMenuVC)
        sideMenu.canCollapse = true
        sideMenu.minimumThickness = Const.sideMenuMinWidth
        sideMenu.maximumThickness = Const.sideMenuMinWidth // TODO: Add possibility to change the side menus width: collapsed<->(minimumThickness...maximumThickness)

        addSplitViewItem(sideMenu)
        addSplitViewItem(NSSplitViewItem(viewController: detailsVC))
    }

    func setupUI() {
       splitView.dividerStyle = .paneSplitter
    }

    enum Const {
        static let sideMenuMinWidth: CGFloat = 200
    }
}
