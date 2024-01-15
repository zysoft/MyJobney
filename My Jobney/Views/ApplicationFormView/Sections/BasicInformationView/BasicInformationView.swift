//
//  BasicInformationView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import SwiftUI

extension ApplicationFormView {
    
    @MainActor
    struct BasicInformationView: View  {
        @State private var vm: ViewModel
        @FocusState private var isCompanyFieldFocused: Bool

        init(position: Binding<String>, company: Binding<Company?>) {
            vm = .init(position: position, company: company)
        }
        
        init(vm: ViewModel) {
            self.vm = vm
        }
        
        var body: some View {
            Section("Basic information") {
                LabeledContent("Position") {
                    TextField(text: $vm.position, prompt: Text("For example Software Engineer")) { EmptyView() }
                }
                
                LabeledContent("Company") {
                    TextField(text: $vm.companyName, prompt: Text("Start typing the name")) { EmptyView() }
                        .focused($isCompanyFieldFocused)
                        .disabled(nil != vm.company)
                        .padding(.trailing, nil != vm.company ? 20 : 0)
                        .overlay(alignment: .trailing) {
                            Button {
                                resetCompany()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .opacity(0.5)
                                    .accessibilityLabel("Clear the selected company")
                            }
                            .buttonStyle(.plain)
                            .opacity(nil != vm.company ? 1 : 0)
                        }
                }
                
                if nil == vm.company {
                    AutoCompleterView(text: vm.companyName, suggestionsProvider: vm.companies) { company in
                        TagView(company.name)
                    } onSuggestionSelect: { company in
                        withAnimation {
                            vm.company = company
                        }
                    }
                }
            }
        }

        private func resetCompany() {
            withAnimation {
                vm.company = nil
                // The delay is needed in order to allow the field to become enabled first, otherwise the focus has no effect.
                DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
                    isCompanyFieldFocused = true
                }
            }
        }
    }
}


#Preview {
    struct ApplicationFormViewBasicInformationViewPreview: View {
        @State private var position = "Some Position"
        @State private var company: Company?
        
        var body: some View {
            Form {
                ApplicationFormView.BasicInformationView(
                    position: $position,
                    company: $company
                )
            }
            .formStyle(.grouped)
            .labeledContentStyle(FormLabeledContentStyle())
        }
    }
    
    return ApplicationFormViewBasicInformationViewPreview()
    
}
