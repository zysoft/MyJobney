//
//  ApplicationFormView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/18/23.
//

import SwiftUI

@MainActor
struct ApplicationFormView: View {
    @State private var vm: ViewModel
    @FocusState private var isCompanyFieldFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    init(application: JobApplication? = nil) {
        _vm = .init(initialValue: .init(application: application))
    }
    
    init(vm: ViewModel) {
        _vm = .init(initialValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    BasicInformationView(
                        position: $vm.position,
                        company: $vm.company
                    )
                    
                    
                    SalaryInformationView(
                        salaryFrom: $vm.salaryMin,
                        salaryTo: $vm.salaryMax,
                        salaryPeriod: $vm.salaryPeriod
                    )
                    
                    AttachedDocumentsView(documents: $vm.documents)
                    
                    Section("Comments") {
                        TextField(text: $vm.comments, prompt: Text("Enter your notes here"), axis: .vertical) { EmptyView() }
                            .multilineTextAlignment(.leading)
                    }
                    
                    BookkeepingInformationView(
                        postingId: $vm.postingId,
                        url: $vm.url
                    )
                    
                    //                Section("History") {
                    //                    HStack {
                    //                        JobStatusTag(status: .created)
                    //                        ForEach(vm.application.history) { record in
                    //                            Image(systemName: "chevron.forward")
                    //                            JobStatusTag(status: record.status)
                    //                        }
                    //                    }
                    //                    .font(.footnote)
                    //                }
                }
                .labeledContentStyle(FormLabeledContentStyle())
                .multilineTextAlignment(.trailing)
                
#if os(macOS)
                HStack {
                    saveButton
                    cancelButton
                }
                .padding()
#endif
            }
            .formStyle(.grouped)
            .navigationTitle("Application")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    cancelButton
                }
                ToolbarItem(placement: .primaryAction) {
                    saveButton
                }
            }
        }
    }
    
    /// The save button which validates and permanently stores the data.
    private var saveButton: some View {
        Button("Save") {
            saveAndDismiss()
        }
    }
    
    /// Cancels the editing.
    private var cancelButton: some View {
        Button("Cancel", role: .cancel, action: dismiss.callAsFunction)
    }
    
    /// Validates and saves the application as long as the form is valid.
    /// Dismisses view on success.
    private func saveAndDismiss() {
        guard vm.save() else {
            // FIXME: Need to show an error if something goes wrong
            return
        }
        dismiss()
    }
}


#Preview {
    ApplicationFormView(application: .init(
        postingId: "123",
        position: "Scarecrow",
        comments: "So much responsibility...",
        salaryFrom: 100_000,
        salaryTo: 100_000_000,
        salaryPeriod: .hour
    ))
    .frame(minHeight: 450)
}

