//
//  AutoCompleterView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/30/23.
//

import SwiftUI


struct AutoCompleterView<Suggestion, Label>: View where Label: View, Suggestion: Identifiable {
    var text: String
    var suggestionsProvider: @MainActor (String) async -> [Suggestion]
    var label: (Suggestion) -> Label
    var onSuggestionSelect: (Suggestion) -> Void
    @State private var suggestions: [Suggestion] = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(suggestions) { data in
                    label(data)
                        .onTapGesture {
                            onSuggestionSelect(data)
                        }
                        .onKeyPress(.return) {
                            onSuggestionSelect(data)
                            return .handled
                        }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .task(id: text) {
            let newSuggestions = await suggestionsProvider(text)
            withAnimation {
                suggestions = newSuggestions
            }
        }
    }
}



#Preview {
    struct AutoCompleterViewPreview: View {
        @State private var text = ""
        var body: some View {
            VStack {
                TextField("Text", text: $text, prompt: Text("Enter one, two, three"))
                AutoCompleterView(text: text, suggestionsProvider: loadSuggestions) {
                    TagView($0.rawValue)
                } onSuggestionSelect: { data in
                    text = data.rawValue
                }
            }
        }
        
        func loadSuggestions(_ val: String) -> [TestItem] {
            TestItem.allCases.filter {
                $0.rawValue.localizedStandardContains(val)
            }
        }
        
        private enum TestItem: String, CaseIterable, Identifiable {
            var id: String { rawValue }
            case zero, one, two, three, four, five, six, seven, eight, nine
        }
    }
    
    return AutoCompleterViewPreview()
        .padding()
}

