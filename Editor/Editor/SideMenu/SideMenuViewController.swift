//
//  SideMenuViewController.swift
//  Editor
//
//  Created by Aleksandr Grebnev1 on 02.07.2022.
//

import Foundation
import AppKit

class SideMenuViewController: NSViewController {

    public lazy var presenter = SideMenuPresenter(with: view())

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        view.wantsLayer = true
    }
    
    public static func fromStoryboard() -> SideMenuViewController {
        let storyboard = NSStoryboard(name: "SideMenu", bundle: Bundle(for: SideMenuViewController.self))
        return storyboard.instantiateInitialController() as! SideMenuViewController
    }
}

private extension SideMenuViewController {
    func view() -> SideMenuView {
        view as! SideMenuView
    }

    func configureCollectionView() {
        view().controlsCollectionView.allowsMultipleSelection = false
        view().controlsCollectionView.delegate = self
        view().controlsCollectionView.dataSource = self
        view().controlsCollectionView.register(NSNib(nibNamed: "SideMenuItem", bundle: Bundle(for: SideMenuItem.self)),
                                               forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: SideMenuItem.reuseId))
    }

    enum Const {
        static let cellSize = NSSize(width: 180, height: 40)
        static let sectionInset = NSEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}

extension SideMenuViewController: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.controls.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cell = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: SideMenuItem.reuseId), for: indexPath) as! SideMenuItem
        cell.itemTitle = presenter.controls[indexPath.item].label
        cell.itemWeight = indexPath.item
        return cell
    }
}

extension SideMenuViewController: NSCollectionViewDelegate {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        guard let index = indexPaths.first?.item else { return }
        presenter.didSelectControl(at: index)
        collectionView.deselectItems(at: indexPaths)
    }
}

extension SideMenuViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        Const.cellSize
    }

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
        Const.sectionInset
    }
}
