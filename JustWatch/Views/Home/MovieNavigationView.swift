//
//  MovieNavigationView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI
import NavigationStack

struct MovieNavigationView: View {
    var body: some View {
        NavigationStackView {
            ZStack {
                MovieHomeView()
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct MovieNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MovieNavigationView()
    }
}
