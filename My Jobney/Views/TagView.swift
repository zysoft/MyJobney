//
//  TagView.swift
//  My Jobney
//
//  Created by Iurii Zisin on 12/19/23.
//

import SwiftUI

/// A view representing a generic tag.
///
/// It can display any content passed in as ``data`` and ``display`` key path.
struct TagView<Data>: View {
    var data: Data
    var display: KeyPath<Data, String>
    var backgroundColor = Color.accentColor
    var foregroundColor = Color("onDarkBackground")

    @FocusState private var isFocused: Bool

    var body: some View {
        Text(data[keyPath: display])
            .padding(4)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .fixedSize(horizontal: true, vertical: false)
            .focusable()
            .focused($isFocused)
            .focusEffectDisabled()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .opacity(isFocused ? 1 : 0)
            }
    }
}


extension TagView where Data == String {
    /// Convenience initializer when using plain string data.
    init(_ data: String, backgroundColor: Color = Color.accentColor, foregroundColor: Color = Color("onDarkBackground")) {
        self.init(data: data, display: \.self, backgroundColor: backgroundColor, foregroundColor: foregroundColor)
    }
}


#Preview {
    return VStack {
        TagView("I am a tag!")
        TagView("I am too!")
        TagView("Success", backgroundColor: .green, foregroundColor: .white)
    }
}
