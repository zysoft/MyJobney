//
//  ApplicationListView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/15/23.
//

import SwiftUI

@MainActor
struct ApplicationListView: View{
    @State private var vm: ViewModel
    @State private var isNewApplicationFormPresented = false
    @Binding var selection: JobApplication?

    init(selection: Binding<JobApplication?>, vm: ViewModel? = nil) {
        _selection = selection
        self.vm = vm ?? .init()
    }
    
    var body: some View {
        List(selection: $selection) {
            ForEach(vm.jobApplications) { application in
                ApplicationListRowView(
                    position: application.position,
                    companyName: application.company?.name,
                    status: application.currentStatus,
                    lastUpdated: application.lastUpdated
                )
                .tag(application)
            }
        }
        .task(id: vm.filter, refresh)
        .task(id: vm.searchString, refresh)
        .searchable(text: $vm.searchString, prompt: "Search")
        .toolbar {
            ToolbarItem(placement: .principal) {
                filter
            }
            ToolbarItem(placement: .navigation) {
                Button("New Application", systemImage: "plus") {
                    isNewApplicationFormPresented = true
                }
            }
        }
        .sheet(isPresented: $isNewApplicationFormPresented) {
            Task {
                await refresh()
            }
        } content: {
            ApplicationFormView()
        }
    }
    
    private var filter: some View {
#if os(macOS)
        let style = SegmentedPickerStyle()
#else
        let style = MenuPickerStyle()
#endif

        return Picker("Filter", selection: $vm.filter) {
            Label("Awaiting", systemImage: "hourglass")
                .tag(ApplicationListFilter.awaiting)
            Label("Applied", systemImage: "text.badge.checkmark.rtl")
                .tag(ApplicationListFilter.applied)
            Label("Rejected", systemImage: "hand.thumbsdown")
                .tag(ApplicationListFilter.rejected)
            Label("All", systemImage: "person.crop.rectangle.stack")
                .tag(ApplicationListFilter.all)
        }
        .pickerStyle(style)
    }
    
    /// A wrapper function to simplify calls to ``ApplicationsViewVM/refreshApplications()`` by making
    /// the wrapped `@Sendable`.
    @Sendable
    private func refresh() async {
        await vm.refreshApplications()
    }
}

#Preview {
    struct PreviewView: View {
        @State private var selection: JobApplication?
        var body: some View {
            ApplicationListView(selection: $selection)
        }
    }
    
    return PreviewView()
}
