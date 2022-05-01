//
//  VoiceOver_DesignerTests.swift
//  VoiceOver DesignerTests
//
//  Created by Mikhail Rubanov on 30.04.2022.
//

import XCTest
@testable import Document

class A11yDescriptionTests: XCTestCase {

    func test_labelOnly() {
        let descr = A11yDescription.testMake(label: "4 сыра")
        
        XCTAssertEqual(descr.voiceOverText, "4 сыра")
    }
    
    func test_labelWithValue() {
        let descr = A11yDescription.testMake(
            label: "Город",
            value: "Екатеринбург")
        
        XCTAssertEqual(descr.voiceOverText, "Город: Екатеринбург")
    }

    func test_labelWithValueAndTrait() {
        let descr = A11yDescription.testMake(
            label: "Город",
            value: "Екатеринбург",
            trait: .button)
        
        XCTAssertEqual(descr.voiceOverText, "Город: Екатеринбург. Кнопка")
    }
}

extension A11yDescription {
    static func testMake(label: String = "",
                         value: String = "",
                         hint: String = "",
                         trait: A11yTraits = .none,
                         frame: CGRect = .zero) -> A11yDescription {
        A11yDescription(label: label,
                        value: value,
                        hint: hint,
                        trait: trait,
                        frame: frame)
    }
}