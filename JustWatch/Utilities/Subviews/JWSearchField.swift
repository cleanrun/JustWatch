//
//  JWTextField.swift
//  JustWatch
//
//  Created by Marchell on 16/02/21.
//

import SwiftUI

struct JWSearchField: View {
    
    var width: CGFloat
    var placeholder: String
    @Binding var textValue: String
    
    var onChange: () -> ()
    
    var body: some View {
        ZStack {
            Capsule().foregroundColor(.LIGHT_GRAY)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray)
                
                TextField(placeholder, text: $textValue)
                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 15).weight(.semibold))
                    .foregroundColor(.gray)
                    .padding([.leading], 2)
                    .onChange(of: textValue, perform: { value in
                        self.onChange()
                    })
            }.padding(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 8))
        }.frame(width: width, height: 50)
    }
}

struct JWSearchField_Previews: PreviewProvider {
    static var previews: some View {
        JWSearchField(width: 300, placeholder: "Search here..", textValue: .constant("Search Query"), onChange: {}).previewLayout(PreviewLayout.sizeThatFits)
    }
}
