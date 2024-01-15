//
//  TestableView.swift
//  My JobneyTests
//
//  Created by Iurii Zisin on 1/2/24.
//

import SwiftUI
import Combine
import ViewInspector

struct TestableView<Content>: View where Content: View {
    var view: Content
    let inspection = Inspection<Self>()
    let publisher = PassthroughSubject<Void, Never>()
    
    var body: some View {
        view
            .onReceive(inspection.notice) {
                inspection.visit(self, $0)
            }
            .onReceive(publisher) { 
                
            }
    }
}


final class Inspection<V> {

    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}

extension Inspection: InspectionEmissary { }
