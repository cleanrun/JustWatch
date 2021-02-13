//
//  MovieHomeView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI

struct MovieHomeView: View {
    
    @StateObject private var viewModel = MovieHomeVM()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color(hex: JWConfig.COLOR_SAPPHIRE)
                    .frame(width: geometry.size.width, height: 300)
                    .cornerRadiusWithEachCorner(100, corners: [.bottomRight])
                
                ScrollView {
                    VStack {
                        
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

class MovieHomeVM: ObservableObject {
    
}

struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
