//
//  SalaryInformationView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import SwiftUI


extension ApplicationFormView {
    struct SalaryInformationView: View  {
        @Binding var salaryFrom: Double?
        @Binding var salaryTo: Double?
        @Binding var salaryPeriod: SalaryPeriod
        @State private var autoRecalculate = false
        
        var body: some View {
            Section("Desired Salary") {
                
                LabeledContent("Salary") {
                    HStack {
                        TextField(value: $salaryFrom, format: .number, prompt: Text("Min")) { EmptyView() }
                            .frame(minWidth: 35)
                            .frame(minWidth: 45, idealWidth: 100, on: .macOS)
                            .layoutPriority(1)
                            .multilineTextAlignment(.trailing)

                        Text("-")
                            .layoutPriority(1)
                        
                        ZStack {
                            // This is just a spacer that
                            Text(salaryTo ?? 0, format: .number)
                                .padding(.trailing, 16, on: .macOS)
                                .frame(minWidth: 35)
                                .frame(minWidth: 45, idealWidth: 100, on: .macOS)
                                .layoutPriority(1)
                                .lineLimit(1)
                                .hidden()
                            TextField(value: $salaryTo, format: .number, prompt: Text("Max")) { EmptyView() }
                                .multilineTextAlignment(.leading)
                                .layoutPriority(0)
                        }
                        .layoutPriority(1)
                    }
                }
                
                LabeledContent("Paid per") {
                    Picker(selection: $salaryPeriod) {
                        Text("year")
                            .tag(SalaryPeriod.year)
                        Text("month")
                            .tag(SalaryPeriod.month)
                        Text("week")
                            .tag(SalaryPeriod.week)
                        Text("hour")
                            .tag(SalaryPeriod.hour)
                    } label: {
                        EmptyView()
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: salaryPeriod, initial: false) { old, new in
                        recalculateSalaries(from: old, to: new)
                    }
                }
                
                Toggle("Recalculate Period", isOn: $autoRecalculate)
            }
            .onAppear {
                autoRecalculate = nil != salaryFrom && nil != salaryTo
            }
        }
        
        /// Recalculates the salary range from one period to another.
        ///
        /// ``salaryFrom`` and ``salaryTo`` will be set according to the `to` period.
        ///
        /// - Parameters:
        ///    - from: Salary period ``salaryFrom`` and ``salaryTo`` are currently specified for.
        ///    - to:   Salary period for which to recalculate the values.
        private func recalculateSalaries(from: SalaryPeriod, to: SalaryPeriod) {
            guard autoRecalculate else {
                return
            }
            if let salaryFrom = salaryFrom {
                self.salaryFrom = (salaryFrom / from.rawValue * to.rawValue).rounded()
            }
            if let salaryTo = salaryTo {
                self.salaryTo = (salaryTo / from.rawValue * to.rawValue).rounded()
            }
        }
    }
}



#Preview {
    struct ApplicationFormViewSalaryInformationViewPreview: View {
        @State private var salaryFrom: Double? = 95
        @State private var salaryTo: Double? = 125
        @State private var salaryPeriod: SalaryPeriod = .hour
        var body: some View {
            Form {
                ApplicationFormView.SalaryInformationView(
                    salaryFrom: $salaryFrom, salaryTo: $salaryTo, salaryPeriod: $salaryPeriod
                )
            }
            .formStyle(.grouped)
            .labeledContentStyle(FormLabeledContentStyle())
        }
    }
    return ApplicationFormViewSalaryInformationViewPreview()
}
