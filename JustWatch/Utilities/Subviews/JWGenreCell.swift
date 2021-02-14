//
//  GenreCell.swift
//  JustWatch
//
//  Created by Marchell on 14/02/21.
//

import SwiftUI

struct JWGenreCell: View {
    
    let genre: String
    let type: GenreType
    
    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Color(hex: JWConfig.COLOR_LIGHT_GRAY)
                
                Image(systemName: "command.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
                    .foregroundColor(Color(hex: type == .movie ? JWConfig.COLOR_SAPPHIRE : JWConfig.COLOR_STRIKEMASTER))
                    .cornerRadius(13)
            }.frame(width: 50, height: 50, alignment: .center)
            .cornerRadius(13)
            
            Text(type == .movie ? genre.toMovieGenre() : genre.toTVGenre())
                .font(Font.custom(JWConfig.FONT_ARIAL, size: 15).weight(.semibold))
                .foregroundColor(Color(hex: type == .movie ? JWConfig.COLOR_SAPPHIRE : JWConfig.COLOR_STRIKEMASTER))
        }.padding(8)
    }
}

enum GenreType {
    case movie
    case tv
}

struct JWGenreCell_Previews: PreviewProvider {
    static var previews: some View {
        JWGenreCell(genre: JWConfig.MOVIE_GENRE_ADVENTURE, type: .movie).previewLayout(PreviewLayout.sizeThatFits)
    }
}
