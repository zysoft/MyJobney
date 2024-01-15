//
//  FormLabeledContentStyle.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import SwiftUI

struct FormLabeledContentStyle: LabeledContentStyle {
    func makeBody(configuration: Configuration) -> some View {
        LabeledContent {
            configuration.content
        } label: {
            configuration.label
                .padding(.vertical, 6, on: .macOS)
        }
    }
}



#Preview {
    Form {
        Section {
            LabeledContent("Some Label") {
                TextField(text: .constant(""), prompt: Text("Type something")) { EmptyView() }
            }
        }
    }
    .formStyle(.grouped)
    .labeledContentStyle(FormLabeledContentStyle())
}
