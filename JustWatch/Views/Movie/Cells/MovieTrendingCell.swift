//
//  MovieCells.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI

// MARK: Main View
struct MovieTrendingCell: View {
    
    @ObservedObject var viewModel: MovieTrendingCellVM
    
    var onTapGesture: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(uiImage: (UIImage(data: viewModel.imageData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_BACKDROP))!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 350, height: 180)
                .clipped()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.title)
                        .padding(EdgeInsets(top: 10, leading: 18, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 25).weight(.bold))
                        .lineLimit(3)
                    Spacer()
                }
                HStack {
                    Text(viewModel.releaseDate)
                        .padding(EdgeInsets(top: 1, leading: 18, bottom: 0, trailing: 0))
                        .foregroundColor(.gray)
                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 14))
                        .lineLimit(1)
                    Spacer()
                }
                Spacer()
                HStack {
                    ForEach(viewModel.genres.prefix(3), id: \.self) { genre in
                        JWPill(text: genre.toMovieGenre(), textSize: 10)
                    }
                }.padding(EdgeInsets(top: 1, leading: 20, bottom: 10, trailing: 0))
            }.frame(minWidth: 0, maxWidth: 280, minHeight: 0, maxHeight: 170)
            
        }.frame(width: 350, height: 180)
        .cornerRadius(25)
        .padding(5)
        .onTapGesture {
            onTapGesture()
        }
    }
}

// MARK: Preview Provider
struct MovieTrendingCell_Previews: PreviewProvider {
    static var previews: some View {
        MovieTrendingCell(viewModel: MovieTrendingCellVM(TMDBMovie())).previewLayout(PreviewLayout.sizeThatFits)
    }
}

// MARK: View Model
class MovieTrendingCellVM: ObservableObject {
    private var movie: TMDBMovie
    
    var ID: Int { movie.ID }
    var title: String { movie.title }
    var releaseDate: String { movie.releaseDate }
    var genres: [String] { movie.genreIDs }
    var backdropPath: String { movie.backdropPath }
    
    @Published var imageData = Data()
    
    init(_ movie: TMDBMovie) {
        self.movie = movie
        getPoster()
    }
    
    func getPoster() {
        let imgUrl = JWConfig.URL_IMAGE_BASE + backdropPath
        JWServices.RequestImage(url: imgUrl, onSuccess: { data in
            self.imageData = data
        }) {
            print("GET IMAGE DATA FAILED")
        }
    }
}
