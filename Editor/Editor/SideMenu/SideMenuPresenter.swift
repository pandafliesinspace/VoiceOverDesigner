//
//  SideMenuPresenter.swift
//  Editor
//
//  Created by Aleksandr Grebnev1 on 02.07.2022.
//

import Foundation
import Document

protocol SideMenuDelegate: AnyObject {
    var controls: [A11yDescription] { get }

    func didSelectControl(at index: Int)
}

class SideMenuPresenter {
    private weak var view: SideMenuView?
    weak var sideMenuDelegate: SideMenuDelegate?

    var controls: [A11yDescription] {
        sideMenuDelegate?.controls ?? []
    }

    init(with view: SideMenuView) {
        self.view = view
    }

    func didSelectControl(at index: Int) {
        sideMenuDelegate?.didSelectControl(at: index)
    }
}

extension SideMenuPresenter: EditorDelegate {
    func didUpdateControls() {
        view?.onDataUpdate()
    }
}
