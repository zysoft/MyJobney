//
//  BookkeepingInformationView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import SwiftUI


extension ApplicationFormView {
    struct BookkeepingInformationView: View  {
        @Binding var postingId: String
        @Binding var url: URL?
        
        var body: some View {
            Section {
                LabeledContent("Posting ID") {
                    TextField(text: $postingId, prompt: Text("Job ID by the poster. Could be needed for reporting")) { EmptyView() }
                }
                LabeledContent("URL") {
                    TextField(value: $url, format: .url, prompt: Text("URL to the description")) { EmptyView() }
                }
            } header: {
                Text("Bookkeeping")
            } footer: {
                Text("The information in this section may be needed to identify the particular job advertisement.")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}


#Preview {
    Form {
        ApplicationFormView.BookkeepingInformationView(
            postingId: .constant("Some ID"), url: .constant(.init(string: "https://localhost.tld"))
        )
    }
    .formStyle(.grouped)
    .labeledContentStyle(FormLabeledContentStyle())
}
