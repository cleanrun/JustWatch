//
//  JWBackButton.swift
//  JustWatch
//
//  Created by Marchell on 16/02/21.
//

import SwiftUI
import NavigationStack

struct JWBackButton: View {
    @EnvironmentObject private var navStack: NavigationStack
    
    var body: some View {
        Button(action: { navStack.pop() } ) {
            Image(systemName: "arrow.backward")
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
                .background(Color.white.frame(width: 60, height: 60))
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
}
