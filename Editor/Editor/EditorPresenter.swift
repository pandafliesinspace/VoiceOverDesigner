//
//  EditorPresenter.swift
//  VoiceOver Designer
//
//  Created by Mikhail Rubanov on 05.05.2022.
//

import Document
import AppKit
import Settings

protocol EditorDelegate: AnyObject {
    func didUpdateControls()
}

class EditorPresenter {
    weak var editorDelegate: EditorDelegate?
    public var document: VODesignDocument!
    var drawingService: DrawingService!
    var router: RouterProtocol!

    func didLoad(ui: NSView, router: RouterProtocol) {
        drawingService = DrawingService(view: ui)
        self.router = router
        
        draw()
    }
    
    func draw() {
        document.controls.forEach(drawingService.drawControl(from:))
    }
    
    func save() {
        let descriptions = drawingService.drawnControls.compactMap { control in
            control.a11yDescription
        }
        
        document.controls = descriptions
        editorDelegate?.didUpdateControls()
    }
    
    // MARK: Mouse
    func mouseDown(on location: CGPoint) {
        if let existedControl = drawingService.control(at: location) {
            drawingService.startTranslating(control: existedControl,
                                            startLocation: location)
        } else {
            drawingService.startDrawing(coordinate: location)
        }
    }
    
    func mouseDragged(on location: CGPoint) {
        drawingService.drag(to: location)
    }
    
    func mouseUp(on location: CGPoint) {
        let action = drawingService.end(coordinate: location)
        
        switch action {
        case .new(let control, let origin):
            document.undoManager?.registerUndo(withTarget: self, handler: { target in
                target.delete(control: control)
            })
            
            save()
        case .translate(let control, let startLocation, let offset):
            save()
        case .click(let control):
            router.showSettings(for: control, controlSuperview: drawingService.view, delegate: self)
        case .none:
            break
        }
    }
}

extension EditorPresenter: SettingsDelegate {
    public func didUpdateValue() {
        save()
    }
    
    public func delete(control: A11yControl) {
        drawingService.delete(control: control)
        save()
    }
}

extension EditorPresenter: SideMenuDelegate {
    var controls: [A11yDescription] {
        document.controls
    }

    func didSelectControl(at index: Int) {
        guard let description = document.controls[nonSafeIndex: index],
              let control = drawingService.drawnControls.first(where: { $0.a11yDescription === description }) else { return }
        router.showSettings(for: control, controlSuperview: drawingService.view, delegate: self)
    }
}

fileprivate extension Array {
    subscript(nonSafeIndex index: Int) -> Element? {
        guard index < count else { return nil }
        return self[index]
    }
}
