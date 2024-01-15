//
//  JobStatusTagView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/19/23.
//

import SwiftUI

struct JobStatusTagView: View {
    var status: JobApplicationStatus?
    
    var body: some View {
        if let status = status {
            TagView(
                data: NSLocalizedString(status.rawValue, comment: "Raw value of JobApplicationStatus"),
                display: \.self,
                backgroundColor: .for(status)
            )
        } 
    }
}


#Preview {
    VStack {
        JobStatusTagView(status: .created)
        JobStatusTagView(status: .applied)
        JobStatusTagView(status: .hired)
        JobStatusTagView(status: .scam)
    }
    .padding()
}
