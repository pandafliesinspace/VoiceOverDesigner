//
//  A11yControl.swift
//  VoiceOver Designer
//
//  Created by Mikhail Rubanov on 30.04.2022.
//

import QuartzCore

public class A11yControl: CALayer {
    private var indexLayer: CATextLayer = {
        let textLayer = CATextLayer()
        textLayer.fontSize = 11
        textLayer.alignmentMode = .center
        textLayer.isWrapped = true
        textLayer.truncationMode = .end
        textLayer.backgroundColor = Color.clear.cgColor
        textLayer.foregroundColor = Color.black.cgColor
        return textLayer
    }()

    public var a11yDescription: A11yDescription?
    
    public func updateColor() {
        backgroundColor = a11yDescription?.color.cgColor
    }
    
    public override var frame: CGRect {
        didSet {
            a11yDescription?.frame = frame
        }
    }

    public override init(layer: Any) {
        super.init(layer: layer)
    }

    public override init() {
        super.init()
        configureIndexLayer()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureIndexLayer()
    }
    
    public var isHiglighted: Bool = false {
        didSet {
            backgroundColor = backgroundColor?.copy(alpha: isHiglighted ? 0.75: 0.5)
            indexLayer.foregroundColor = indexLayer.foregroundColor?.copy(alpha: isHiglighted ? 1 : 0.75)
        }
    }
    
    public func setIndex(_ newIndex: Int) {
        indexLayer.string = String(newIndex) // TODO: Index(weight) should be assigned from outside or should be carried by A11yDescription?
    }
}

private extension A11yControl {
    func configureIndexLayer() {
        addSublayer(indexLayer)
        indexLayer.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
    }
}
