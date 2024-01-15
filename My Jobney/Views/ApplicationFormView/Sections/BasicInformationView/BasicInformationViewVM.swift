//
//  BasicInformationViewVM.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import SwiftUI
import Observation

extension ApplicationFormView.BasicInformationView {
    
    @MainActor
    @Observable class ViewModel {
        var companyName = ""
        var position: String {
            didSet { positionBinding.wrappedValue = position }
        }
        var company: Company? {
            didSet {
                companyBinding.wrappedValue = company
                companyName = company?.name ?? ""
            }
        }
        
        private var positionBinding: Binding<String>
        private var companyBinding: Binding<Company?>
        
        @ObservationIgnored
        private var storageService = Dependency.Service[\.storage]
        
        
        init(position: Binding<String>, company: Binding<Company?>) {
            positionBinding = position
            companyBinding = company
            companyName = company.wrappedValue?.name ?? ""
            self.company = company.wrappedValue
            self.position = position.wrappedValue
        }
        
        func companies(matching search: String) async -> [Company] {
            let query = #Predicate<Company> { company in
                company.name.localizedStandardContains(search)
            }
            return storageService.query(withPredicate: query, orderBy: [ .init(\.name, order: .forward) ])
        }
    }
}
