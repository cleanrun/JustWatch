//
//  GenreCell.swift
//  JustWatch
//
//  Created by Marchell on 03/03/21.
//

import SwiftUI

// MARK: Main View
struct GenreCell: View {
    
    var genreCode: String
    var genreType: SearchType
    var onTapGesture: () -> Void = {}
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(8)
                .shadow(radius: 3)
            
            HStack {
                Text(genreType == .movie ? genreCode.toMovieGenre() : genreCode.toTVGenre())
                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 18).weight(.semibold))
                    .foregroundColor(genreType == .movie ? .SAPPHIRE : .STRIKEMASTER)
                    .padding([.leading], 30)
                
                Spacer()
            }
        }.frame(height: 50)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 3, trailing: 16))
    }
}

// MARK: Preview Provider
struct GenreCell_Previews: PreviewProvider {
    static var previews: some View {
        GenreCell(genreCode: "28", genreType: .movie).previewLayout(.sizeThatFits)
    }
}
