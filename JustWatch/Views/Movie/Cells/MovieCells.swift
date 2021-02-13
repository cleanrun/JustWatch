//
//  MovieCells.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI

struct MovieTrendingCell: View {
    var body: some View {
        ZStack {
            Image(JWConfig.IMG_PLACEHOLDER_MOVIE_POSTER)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            VStack {
                Text("How To Train Your Dragon")
            }
        }.frame(width: 350, height: 180)
        .cornerRadius(25)
        .padding(5)
    }
}

struct MovieTrendingCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrendingCell().previewLayout(PreviewLayout.sizeThatFits)
    }
}
