//
//  TVNavigationView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI
import NavigationStack

struct TVNavigationView: View {
    var body: some View {
        NavigationStackView {
            ZStack {
                TVHomeView()
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct TVNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TVNavigationView()
    }
}
