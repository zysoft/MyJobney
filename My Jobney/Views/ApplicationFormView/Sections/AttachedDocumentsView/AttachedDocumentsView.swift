//
//  AttachedDocumentsView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/2/24.
//

import SwiftUI

extension ApplicationFormView {
    @MainActor
    struct AttachedDocumentsView: View {
        @Binding var documents: [FiledDocument]
        @State private var vm: ViewModel = .init()
        @State private var isFilePickerPresented = false

        init(documents: Binding<[FiledDocument]>, vm: ViewModel? = nil) {
            _documents = documents
            _vm = .init(initialValue: vm ?? .init())
        }
        
        var body: some View {
            Section {
                if documents.isNotEmpty {
                    List {
                        ForEach($documents) { $document in
                            HStack {
                                Text(document.name)
                            }
                        }
                    }
                }
                
                if documents.isEmpty {
                    Text("No documents")
                        .opacity(0.5)
                }
            } header: {
                HStack {
                    Text("Documents")
                    Spacer()
                    Button("Add", systemImage: "plus") {
                        isFilePickerPresented = true
                    }
                    .buttonStyle(.plain)
                }
            } footer: {
                Text("Tap \"+\" to add a document. " +
                     "Documents could include your resume, cover letter, or any other document you want to remember along with the application")
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .fileImporter(isPresented: $isFilePickerPresented, allowedContentTypes: [.data]) { result in
                switch result {
                case .success(let url):
                    Task {
                        if let document = await vm.addDocument(from: url) {
                            documents.append(document)
                        }
                    }
                case .failure(_):
                    // FIXME: Handle error
                    break
                }
            }
        }
    }
}


#Preview {
    struct ApplicationFormViewAttachedDocumentsView: View {
        @State private var documents: [FiledDocument] = []
        var body: some View {
            Form {
                ApplicationFormView.AttachedDocumentsView(documents: $documents)
            }
            .formStyle(.grouped)
        }
    }
    
    return ApplicationFormViewAttachedDocumentsView()
}
