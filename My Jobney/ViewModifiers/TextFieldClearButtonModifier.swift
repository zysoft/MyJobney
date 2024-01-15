//
//  TextFieldClearButtonModifier.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/29/23.
//

import SwiftUI



fileprivate struct TextFieldClearButtonModifier: ViewModifier {
    @Binding var text: String
    var onClear: (() -> Void)?
    
    func body(content: Content) -> some View {
        HStack {
            content
            
            Button(action: clearText) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .opacity(0.5)
                    .accessibilityLabel("Clear button")
            }
            .buttonStyle(.plain)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
    
    private func clearText() {
        text = ""
        onClear?()
    }
}

extension View {
    func clearButton(clearing textBinding: Binding<String>, onClear action: (() -> Void)? = nil) -> some View {
        self
            .modifier(TextFieldClearButtonModifier(text: textBinding, onClear: action))
    }
}


#Preview {
    struct TextFieldClearButtonModifierPreview: View {
        @State private var text = ""
        var body: some View {
            TextField("Preview", text: $text, prompt: Text("Try me"))
                .clearButton(clearing: $text)
        }
    }
    return TextFieldClearButtonModifierPreview()
        .padding(.horizontal)
        
    
}
