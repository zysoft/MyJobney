//
//  EducationEditView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import SwiftUI

extension ResumeFormView {
    
    @MainActor
    struct ExperienceEditView: View {
        @Environment(\.dismiss) private var dismiss
        @State private var vm: ViewModel
        @FocusState private var bulletPointFocused

        init(experienceRecord: ExperienceRecord?, resume: Resume) {
            _vm = .init(initialValue: .init(experienceRecord: experienceRecord, resume: resume))
        }
        
        init(vm: ViewModel) {
            _vm = .init(initialValue: vm)
        }
        
        var body: some View {
            NavigationStack {
                VStack {
                    Form {
                        Section("Basic Information") {
                            LabeledContent("Position") {
                                TextField(text: $vm.experienceRecord.position, prompt: Text("Position title")) { EmptyView() }
                            }
                            
                            LabeledContent("Company") {
                                TextField(text: $vm.experienceRecord.company, prompt: Text("The name of the company")) { EmptyView() }
                            }
                            DatePicker("Started", selection: $vm.experienceRecord.dateStarted, in: .distantPast ... .now, displayedComponents: [.date])
                            
                            if !vm.isCurrentPosition {
                                DatePicker("Ended", selection: $vm.experienceEndDate, displayedComponents: [.date])
                            }
                            
                            Toggle("I currently work there", isOn: $vm.isCurrentPosition)
                        }
                        
                        Section("Achievements") {
                            List {
                                ForEach(vm.extraContent.bulletPoints, id: \.self) { bulletPoint in
                                    HStack(alignment: .top) {
                                        Text("•")
                                        Text(bulletPoint)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .swipeActions {
                                                Button("Delete", role: .destructive) {
                                                    vm.delete(bulletPoint: bulletPoint)
                                                }
                                            }
                                    }
                                }
                                .multilineTextAlignment(.leading)
                            }
                            
                            HStack(alignment: .lastTextBaseline) {
                                TextField(text: $vm.bulletPoint, prompt: Text("Add more achievements"), axis: .vertical) { EmptyView() }
                                    .focused($bulletPointFocused)
                                    .multilineTextAlignment(.leading)
                                    .submitLabel(.return)
                                    .onSubmit {
                                        vm.addBulletPoint()
                                        bulletPointFocused = true
                                    }
                                
                                Button("Add", systemImage: "return") {
                                    vm.addBulletPoint()
                                    bulletPointFocused = true
                                }
                                .labelStyle(.iconOnly)
                                .buttonStyle(.plain)
                            }
                        }
                    }
#if os(macOS)
                    HStack {
                        saveButton
                        cancelButton
                    }
                    .padding()
#endif
                }
                .multilineTextAlignment(.trailing)
                .formStyle(.grouped)
                .navigationTitle("Experience")
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
}


// MARK: - Preview

#Preview("Random Experience") {
    struct ResumeFormView_ExperienceEditView_Preview: View {
        @State private var resume: Resume = Dependency.Service[\.storage].query().first!
        var body: some View {
            ResumeFormView.ExperienceEditView(experienceRecord: resume.experience.first, resume: resume)
        }
    }
    
    return ResumeFormView_ExperienceEditView_Preview()
}


#Preview("Empty Experience") {
    struct ResumeFormView_ExperienceEditView_Preview: View {
        @State private var resume: Resume = Dependency.Service[\.storage].query().first!
        var body: some View {
            ResumeFormView.ExperienceEditView(experienceRecord: nil, resume: resume)
        }
    }
    
    return ResumeFormView_ExperienceEditView_Preview()
}
