//
//  ExperienceView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/13/24.
//

import SwiftUI

extension ResumeFormView {
    
    struct ExperienceView: View {
        @Bindable var resume: Resume
        @State private var selectedRecord: Selection<ExperienceRecord>?

        var body: some View {
            Section {
                List {
                    ForEach(resume.experience) { experience in
                        VStack(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(experience.position)
                                    Text(experience.company)
                                        .font(.footnote)
                                }
                                Spacer()
                                Group {
                                    Text(experience.dateStarted, formatter: Formatters.monthAndYear)
                                    Text("-")
                                    if let finished = experience.dateFinished {
                                        Text(finished, formatter: Formatters.monthAndYear)
                                    } else {
                                        Text("present")
                                    }
                                }
                                .font(.footnote)
                            }
                            .swipeActions {
                                Button("Remove", role: .destructive) {
                                    //                                        vm.delete(education)
                                }
                                Button("Edit") {
                                    selectedRecord = .init(item: experience)
                                }
                            }
                            .padding(.bottom)

                            ForEach(experience.content?.bulletPoints ?? [], id: \.self) { bulletPoint in
                                HStack(alignment: .top) {
                                    Text("•")
                                    Text(bulletPoint)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                            .font(.footnote)
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Experience")
                    Spacer()
                    Button("Add", systemImage: "plus") {
                        selectedRecord = .init()
                    }
                    .buttonStyle(.plain)
                }
            }
            .sheet(item: $selectedRecord) { record in
                ResumeFormView.ExperienceEditView(experienceRecord: record.item, resume: resume)
            }
        }
    }
}



#Preview {
    struct ResumeFormView_ExperienceView_Preview: View {
        @State private var resume: Resume = Dependency.Service[\.storage].query().first!
        var body: some View {
            Form {
                ResumeFormView.ExperienceView(resume: resume)
            }
            .formStyle(.grouped)
        }
    }
    
    return ResumeFormView_ExperienceView_Preview()
}
