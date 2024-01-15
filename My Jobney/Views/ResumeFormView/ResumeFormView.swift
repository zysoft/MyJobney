//
//  ResumeFormView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/5/24.
//

import SwiftUI

@MainActor
struct ResumeFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var vm: ViewModel
    
    init(resume: Resume? = nil) {
        _vm = .init(initialValue: .init(resume: resume))
    }
    
    init(vm: ViewModel) {
        _vm = .init(initialValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    LabeledContent("Title") {
                        TextField(text: $vm.title, prompt: Text("Some name to identify it in the list")) { EmptyView() }
                    }
                    
                    Section("Contact Information") {
                        LabeledContent("Name") {
                            TextField(text: $vm.name, prompt: Text("Your name (usually the legal one)")) { EmptyView() }
                        }
                        LabeledContent("Email") {
                            TextField(text: $vm.email, prompt: Text("Your email")) { EmptyView() }
                        }
                        LabeledContent("Phone") {
                            TextField(text: $vm.phone, prompt: Text("Your phone number")) { EmptyView() }
                        }
                        LabeledContent("Location") {
                            TextField(text: $vm.location, prompt: Text("City, State")) { EmptyView() }
                        }
                    }
                    
                    Section("Summary") {
                        TextField(text: $vm.summarySection.sectionDescription, prompt: Text("Write some information about yourself"), axis: .vertical) { EmptyView() }
                            .multilineTextAlignment(.leading)
                    }
                    
                    EducationView(resume: vm.resume)
                    
                    ExperienceView(resume: vm.resume)
                    
                    SkillsView(resume: vm.resume)
                }
                
#if os(macOS)
                HStack {
                    saveButton
                    cancelButton
                }
                .padding()
#endif
            }
            .formStyle(.grouped)
            .labeledContentStyle(FormLabeledContentStyle())
            .multilineTextAlignment(.trailing)
            .navigationTitle(vm.name.isEmpty ? String(localized: "Resume") : vm.name)
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
            vm.save()
            dismiss()
        }
    }
    
    /// Cancels the editing.
    private var cancelButton: some View {
        Button("Cancel", role: .cancel, action: dismiss.callAsFunction)
    }
}


// MARK: - Previews


#Preview("Random resume") {
    ResumeFormView(resume: Dependency.Service[\.storage].query().first)
}

#Preview("Empty resume") {
    ResumeFormView()
}
