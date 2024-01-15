//
//  EducationEditView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import SwiftUI

extension ResumeFormView {
    
    @MainActor
    struct EducationEditView: View {
        @Environment(\.dismiss) private var dismiss
        @State private var vm: ViewModel

        init(educationRecord: EducationRecord?, resume: Resume) {
            _vm = .init(initialValue: .init(educationRecord: educationRecord, resume: resume))
        }
        
        init(vm: ViewModel) {
            _vm = .init(initialValue: vm)
        }
        
        var body: some View {
            NavigationStack {
                VStack {
                    Form {
                        Section {
                            LabeledContent("Institution") {
                                TextField(text: $vm.educationRecord.institutionName, prompt: Text("Place of study")) { EmptyView() }
                            }
                            
                            LabeledContent("Major") {
                                TextField(text: $vm.educationRecord.major, prompt: Text("What's your major")) { EmptyView() }
                            }
                            DatePicker("Started", selection: $vm.educationRecord.dateStarted, in: .distantPast ... .now, displayedComponents: [.date])
                            if nil != vm.educationRecord.diploma {
                                DatePicker("Graduation", selection: $vm.educationRecord.dateFinished, displayedComponents: [.date])
                            }
                            Picker("Diploma", selection: $vm.educationRecord.diploma) {
                                Text("Still Studying")
                                    .tag(nil as DiplomaType?)
                                
                                ForEach(DiplomaType.allCases) { diplomaType in
                                    Text(diplomaType.localizedDescription)
                                        .tag(diplomaType as DiplomaType?)
                                }
                                
                            }
                            .pickerStyle(.menu)
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
                .formStyle(.grouped)
                .navigationTitle("Education")
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


#Preview {
    struct ResumeFormView_EducationEditView_Preview: View {
        @State private var resume: Resume = Dependency.Service[\.storage].query().first!
        var body: some View {
            ResumeFormView.EducationEditView(educationRecord: resume.education.first, resume: resume)
        }
    }
    
    return ResumeFormView_EducationEditView_Preview()
}
