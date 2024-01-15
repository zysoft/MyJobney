//
//  PreviewData.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/27/23.
//

import SwiftData

#if DEBUG

/// Utility for handling data for previews
struct PreviewData {

    /// Loads the preview data into the given storage.
    ///
    /// <red>Make sure you're using a temporary storage.</red>
    static func load(into storage: StorageService = Dependency.Service[\.storage]) {
        let company = Company(name: "My Dream Company", url: .init(string: "https://www.dream.company.local")!, comments: "The best company to work at")
        let otherCompany = Company(name: "Other company", comments: "Almost as good as My Dream Company")
        storage.store(company)
        storage.store(otherCompany)
        
        let application = JobApplication(
            postingId: "01234",
            url: .init(string: "https://www.dream.company.local/jobs/01234"),
            position: "Fluffy Exhibit #1",
            comments: "Finally, I was invited!",
            salaryFrom: 100_000,
            salaryTo: 200_000,
            salaryPeriod: .year,
            company: company
        )
        var status = JobApplicationStatusRecord(status: .applied, date: .now.addingTimeInterval(-10*24*60*60))

        application.addStatus(status)
        
        application.lastUpdated = .now
        
        storage.store(application)
        

        let otherApplication = JobApplication(
            postingId: "5432",
            url: .init(string: "https://www.some.job.board.local/5432"),
            position: "Hare Impersonator",
            comments: "You gotta do what you gotta do",
            salaryFrom: 10_000,
            salaryPeriod: .month,
            company: otherCompany
        )
        
        status = JobApplicationStatusRecord(status: .applied, date: .now.addingTimeInterval(-24*60*60))
        otherApplication.addStatus(status)
        
        status = JobApplicationStatusRecord(status: .notSelected)
        otherApplication.addStatus(status)
        storage.store(application)
        
        
        // Sample resume
        let resume = Resume(
            title: "The Rabbit",
            name: "Bunny F Rabbit",
            email: "rabbit@bunny-mail.tld",
            summary: ResumeArbitrarySection(
                sectionDescription: "A very nice rabbit, loved by the everybody. You can feed me. Do not bite. Playful."
            ),
            education: [
                try! .init(institutionName: "Rabbit Hole College", major: "Food Devouring", diploma: .phd, dateStarted: .init("1995-12-23T00:00:00Z", strategy: .iso8601), dateFinished: .init("1998-02-15T00:00:00Z", strategy: .iso8601)),
            ],
            experience: [
                try! .init(position: "Junior Eater", company: "Nice People's House", dateStarted: .init("1998-02-15T00:00:00Z", strategy: .iso8601), dateFinished: .init("1998-05-12T00:00:00Z", strategy: .iso8601), content: ResumeArbitrarySection(
                    bulletPoints: [
                        "Ate 43 carrots in 1 hour",
                        "Furnished a personal nest",
                        "Shredded 3 important papers",
                    ]
                )),
                try! .init(position: "Sr. Devourer", company: "Nice People's House", dateStarted: .init("1998-05-12T00:00:00Z", strategy: .iso8601), content: ResumeArbitrarySection(
                    bulletPoints: [
                        "Bit 2 dogs",
                        "Decreased toys life by 10%",
                        "Decorated a carpet with nice dots",

                    ]
                ))
            ],
            additionalSections: [
                .init(
                    title: "My Principles",
                    bulletPoints: [
                        "I will eat your brains if you don't like me",
                        "If you think that one carrot is enough - think again",
                        "You live to admire me, never forget that",
                    ]
                )
            ],
            skills: [
                .init(title: "Eating", yearsOfExperience: 20),
                .init(title: "Sleeping", yearsOfExperience: 19),
                .init(title: "Slight property downgrade", yearsOfExperience: 19),
                .init(title: "Toys destruction", yearsOfExperience: 15),
            ]
            
        )
        
        storage.store(resume)

    }
    
}
#endif
