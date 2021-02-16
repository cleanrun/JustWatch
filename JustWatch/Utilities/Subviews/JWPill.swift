//
//  JWPill.swift
//  JustWatch
//
//  Created by Marchell on 14/02/21.
//

import SwiftUI

struct JWPill: View {
    
    var text: String
    var textSize: Int
    var tapGesture: () -> Void
    
    @Binding var isActive: Bool
    
    init(text: String, textSize: Int, isActive: Binding<Bool> = .constant(false), tapGesture: @escaping () -> Void = {} ) {
        self.text = text
        self.textSize = textSize
        self.tapGesture = tapGesture
        _isActive = isActive
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(isActive ? .SAPPHIRE : .white)
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .font(Font.custom("Arial", size: CGFloat(textSize)).weight(.bold))
            .background(isActive ? .DANUBE : Color.black.opacity(0.4))
            .lineLimit(1)
            .cornerRadius(13)
            .onTapGesture {
                self.tapGesture()
            }
    }
}

struct JWBorderPill: View {
    
    var text: String
    var textSize: Int
    var tapGesture: () -> Void = {}
    
    var body: some View {
        Text(text)
            .foregroundColor(.gray)
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .font(Font.custom("Arial", size: CGFloat(textSize)).weight(.bold))
            .lineLimit(1)
            .overlay(RoundedRectangle(cornerRadius: 13).stroke(Color.gray))
            .onTapGesture {
                self.tapGesture()
            }
    }
}

struct JWPill_Previews: PreviewProvider {
    static var previews: some View {
        JWPill(text: "Animation", textSize: 13).previewLayout(PreviewLayout.sizeThatFits)
    }
}
