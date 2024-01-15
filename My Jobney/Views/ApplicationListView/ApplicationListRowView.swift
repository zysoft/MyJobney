//
//  ApplicationListRowView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/25/23.
//

import SwiftUI


struct ApplicationListRowView: View {
    var position: String
    var companyName: String? = nil
    var status: JobApplicationStatus
    var lastUpdated: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(position)
                Text(companyName ?? "")
                    .font(.footnote)
                HStack {
                    JobStatusTagView(status: status)
                    Text(lastUpdated, format: .relative(presentation: .named))
                }
                .font(.footnote)
            }
            Spacer()
            Image(systemName: "chevron.forward")
        }
    }
}



#Preview {
    VStack {
        ApplicationListRowView(position: "Some Cool Position", companyName: "Some LLC", status: .applied, lastUpdated: .now.addingTimeInterval(-240000))
        ApplicationListRowView(position: "Another Cool Position", status: .applied, lastUpdated: .now.addingTimeInterval(-240000))
    }
    .padding()
}
