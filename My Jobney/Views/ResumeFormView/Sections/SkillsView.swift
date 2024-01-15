//
//  SkillsView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/14/24.
//

import OrderedCollections
import SwiftUI

extension ResumeFormView {
    
    struct SkillsView: View {
        @Bindable var resume: Resume
        @State private var newSkill = ""
        @State private var yearsOfExperience = ""
        @FocusState private var focusedField: FocusedField?
        
        var body: some View {
            Section("Skills") {
                List {
                    ForEach(resume.skills) { skill in
                        HStack {
                            Text(skill.title)
                            if skill.yearsOfExperience > 0 {
                                Spacer()
                                Text("\(skill.yearsOfExperience) years")
                            }
                        }
                    }
                }
                
                HStack(alignment: .lastTextBaseline) {
                    TextField(text: $newSkill, prompt: Text(resume.skills.isEmpty ? "Add skills" : "Add more skills"), axis: .vertical) { EmptyView() }
                        .focused($focusedField, equals: .skillInput)
                        .multilineTextAlignment(.leading)
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = .yearsInput
                        }

                    TextField(text: $yearsOfExperience, prompt: Text("Years"), axis: .vertical) { EmptyView() }
                        .frame(maxWidth: 50)
                        .focused($focusedField, equals: .yearsInput)
                        .multilineTextAlignment(.leading)
                        .submitLabel(.return)
                        .onSubmit(addSkill)

                    Button("Add", systemImage: "return", action: addSkill)
                        .labelStyle(.iconOnly)
                        .buttonStyle(.plain)
                }
                
            }
        }
        
        private func addSkill() {
            guard newSkill.isNotEmpty else { return }
            resume.skills.append(.init(title: newSkill, yearsOfExperience: Int(yearsOfExperience) ?? 0))
            focusedField = .skillInput
            newSkill = ""
            yearsOfExperience = ""
        }
    }
}

// MARK: - Focus state

private extension ResumeFormView.SkillsView {
    enum FocusedField {
        case skillInput, yearsInput
    }
}


#Preview {
    struct ResumeFormView_SkillsView_Preview: View {
        @State private var resume: Resume = Dependency.Service[\.storage].query().first!
        var body: some View {
            Form {
                ResumeFormView.SkillsView(resume: resume)
            }
            .formStyle(.grouped)
        }
    }
    return ResumeFormView_SkillsView_Preview()
}
