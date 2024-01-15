//
//  ResumeListView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 1/5/24.
//

import SwiftUI

@MainActor
struct ResumeListView: View{
    @Binding var selection: Resume?
    @State private var vm: ViewModel
    @State private var isNewResumeFormPresented = false

    init(selection: Binding<Resume?>, vm: ViewModel? = nil) {
        _selection = selection
        self.vm = vm ?? .init()
    }
    
    var body: some View {
        List(selection: $selection) {
            ForEach(vm.resumes) { resume in
                VStack(alignment: .leading) {
                    Text(resume.title)
                    Text("\(resume.education.count) educations, \(resume.experience.count) workplaces, \(resume.skills.count) skills")
                        .font(.footnote)
                }
                .tag(resume)
                
            }
        }
        .task {
            await vm.refreshResumes()
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("New Resume", systemImage: "plus") {
                    selection = nil
                    isNewResumeFormPresented = true
                }
            }
        }
        .sheet(isPresented: $isNewResumeFormPresented) {
            ResumeFormView(resume: selection)
        }
    }
}

#Preview {
    struct PreviewView: View {
        @State private var selection: Resume?
        var body: some View {
            ResumeListView(selection: $selection)
        }
    }
    
    return PreviewView()
}
