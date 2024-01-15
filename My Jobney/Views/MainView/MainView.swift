//
//  MainView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/13/23.
//

import SwiftUI

@MainActor
struct MainView: View {
    @State private var menuSelection: SidebarMenu? = .applications
    @State private var selectedApplication: JobApplication?
    @State private var selectedResume: Resume?

    var body: some View {
        NavigationSplitView {
            sidebar
        } content: {
            content
        } detail: {
            detail
        }

    }

    private var sidebar: some View {
        List(selection: $menuSelection) {
            Label("Applications", systemImage: "briefcase")
                .tag(SidebarMenu.applications)

            Label("Resumes", systemImage: "scroll")
                .tag(SidebarMenu.resumes)

            Label("Cover Letters", systemImage: "envelope")
                .tag(SidebarMenu.coverLetters)

            Label("Companies", systemImage: "building.2")
                .tag(SidebarMenu.companies)
            
            Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                .tag(SidebarMenu.stats)

            Label("My Diary", systemImage: "pencil.and.scribble")
                .tag(SidebarMenu.myDiary)
            
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch menuSelection {
        case .applications, .none:
            ApplicationListView(selection: $selectedApplication)
                .navigationTitle("Applications")
        case .resumes:
            ResumeListView(selection: $selectedResume)
                .navigationTitle("Resumes")
        case .coverLetters:
            Text("Cover Letters")
                .navigationTitle("Cover Letters")
        case .companies:
            Text("Companies")
                .navigationTitle("Companies")
        case .myDiary:
            Text("Diary")
                .navigationTitle("Diary")
        case .stats:
            EmptyView()
                .navigationTitle("Stats")
        }
    }
    
    @ViewBuilder
    private var detail: some View {
        switch menuSelection {
        case .applications, .none:
            if let application = selectedApplication {
                VStack {
                    Text(application.position)
                    Text(application.documents.count, format: .number)
                }
            } else {
                Text("Apps")
            }
        case .resumes:
            Text("Resumes")
        case .coverLetters:
            Text("Cover letters")
        case .companies:
            Text("Companies")
        case .myDiary:
            Text("Diary")
        case .stats:
            Text("Please select an item on the left")
        }
    }
}


// MARK: - Preview

#Preview {
    MainView()
}
