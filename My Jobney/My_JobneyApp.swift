//
//  My_JobneyApp.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/11/23.
//

import SwiftUI

@main
struct My_JobneyApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .task {
                    try? await Dependency.Service[\.documentService].collectGarbage()
                }
        }
        .commands {
            MyJobneyCommands()
        }
    }
    
    init() {
        // To simplify working with previews, when running for previews,
        // it's good to have some sample data ready.
        if ExecutionEnvironment.current == .preview {
            PreviewData.load()
        }
    }
}
