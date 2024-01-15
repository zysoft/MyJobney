//
//  EducationView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/12/24.
//

import SwiftUI

extension ResumeFormView {

    @MainActor
    struct EducationView: View {
        @Bindable var resume: Resume
        @State private var selectedRecord: Selection<EducationRecord>?
        
        var body: some View {
            Section {
                List {
                    ForEach(resume.education) { record in
                        row(forEducationRecord: record)
                            .swipeActions {
                                Button("Remove", role: .destructive) {
                                    delete(record)
                                }
                                Button("Edit") {
                                    selectedRecord = .init(item: record)
                                }
                            }
                    }
                }
            } header: {
                HStack {
                    Text("Education")
                    Spacer()
                    Button("Add", systemImage: "plus") {
                        selectedRecord = .init()
                    }
                    .buttonStyle(.plain)
                }
            }
            .sheet(item: $selectedRecord) { record in
                ResumeFormView.EducationEditView(educationRecord: record.item, resume: resume)
            }
        }
        
        private func row(forEducationRecord record: EducationRecord) -> some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(record.major)
                    Text(record.institutionName)
                        .font(.footnote)
                }
                Spacer()
                Group {
                    Text(record.dateStarted, formatter: Formatters.monthAndYear)
                    Text("-")
                    if nil != record.diploma {
                        Text(record.dateFinished, formatter: Formatters.monthAndYear)
                    } else {
                        Text("present")
                    }
                }
                .font(.footnote)
            }
        }
        
        private func delete(_ record: EducationRecord) {
            resume.education.removeAll { $0 == record }
        }
    }
}


#Preview {
    struct ResumeFormView_EducationView_Preview: View {
        @State private var resume: Resume = Dependency.Service[\.storage].query().first!
        var body: some View {
            Form {
                ResumeFormView.EducationView(resume: resume)
            }
            .formStyle(.grouped)
        }
    }
    
    return ResumeFormView_EducationView_Preview()
}
