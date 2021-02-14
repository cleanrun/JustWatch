//
//  SearchNavigationView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI
import NavigationStack

struct SearchNavigationView: View {
    var body: some View {
        NavigationStackView {
            ZStack {
                Color.purple
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct SearchNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SearchNavigationView()
    }
}
