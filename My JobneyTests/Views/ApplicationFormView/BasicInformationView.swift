//
//  BasicInformationView.swift
//  My JobneyTests
//
//  Created by Iurii Zisin on 1/2/24.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import My_Jobney

@MainActor
final class ApplicationFormView_BasicInformationViewTest: XCTestCase {
    @TestBinding private var position = ""
    @TestBinding private var company: Company?
    private var view = TestableView(view: ApplicationFormView.BasicInformationView(position: .constant(""), company: .constant(nil)))
    
    override func setUpWithError() throws {
        view = .init(view: ApplicationFormView.BasicInformationView(vm: MockBasicInformationViewVM(position: $position, company: $company)))
    }
    
    func testAutoCompleter() throws {
        let exp1 = view.inspection.inspect { view in
            let autocompletionRow = try view.find(AutoCompleterView<Company, TagView<String>>.self)
            let tagList = try autocompletionRow.scrollView().lazyHGrid()
            
            XCTAssertEqual(0, tagList.findAll(TagView<String>.self).count)

            let companyInput = try view.find(ViewType.Section.self).labeledContent(1).textField(0)
            try XCTAssertEqual("", companyInput.input())

            try companyInput.setInput("t")
            try XCTAssertEqual("t", companyInput.input())
            
            let ex = self.expectation(description: "")
            ex.isInverted = true
            self.wait(for: [ex], timeout: 2)
            
            self.view.publisher.send()
        }
        
        let exp2 = view.inspection.inspect(onReceive: view.publisher) { view in
            try dump(view.actualView())
//            XCTAssertEqual(1, view.findAll(TagView<String>.self).count)
//            XCTAssertEqual(1, view.find(text: "Two"))

        }

        
        ViewHosting.host(view: view)
        wait(for: [exp1, exp2], timeout: 5)
        
    }
}

extension View {
    func dumpViewHierarchy(indent: Int = 0) {
        let mirror = Mirror(reflecting: self)
        let indentation = String(repeating: " ", count: indent)
        print("\(indentation)\(type(of: self))")
        
        var foundView = false
        for child in mirror.children {
            if let childView = child.value as? any View {
                childView.dumpViewHierarchy(indent: indent+1)
                foundView = true
            }
        }
        if !foundView && !(self is Text) {
            self.body.dumpViewHierarchy(indent: indent+1)
        }
    }
}


fileprivate class MockBasicInformationViewVM: ApplicationFormView.BasicInformationView.ViewModel {
    override func companies(matching search: String) async -> [Company] {
        [
            .init(name: "One"),
            .init(name: "Two"),
            .init(name: "Three"),
        ]
            .filter {
                $0.name.localizedStandardContains(search)
            }

    }
}
