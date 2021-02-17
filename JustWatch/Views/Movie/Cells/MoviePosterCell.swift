//
//  MoviePosterCell.swift
//  JustWatch
//
//  Created by Marchell on 14/02/21.
//

import SwiftUI

// MARK: Main View
struct MoviePosterCell: View {
    
    @ObservedObject var viewModel: MoviePosterCellVM
    var onTapGesture: () -> Void = {}
    
    var body: some View {
        ZStack {
            Image(uiImage: (UIImage(data: viewModel.imageData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_POSTER))!)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }.frame(width: 200, height: 390, alignment: .center)
        .cornerRadius(25)
        .padding(5)
        .onTapGesture {
            onTapGesture()
        }
    }
}

// MARK: Preview Provider
struct MoviePosterCell_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCell(viewModel: MoviePosterCellVM(TMDBMovie())).previewLayout(PreviewLayout.sizeThatFits)
    }
}

// MARK: View Model
class MoviePosterCellVM: ObservableObject {
    private var movie: TMDBMovie
    
    var ID: Int { movie.ID }
    var title: String { movie.title }
    var posterPath: String { movie.posterPath }
    
    @Published var imageData = Data()
    
    init(_ movie: TMDBMovie) {
        self.movie = movie
        getPoster()
    }
    
    func getPoster() {
        let imgUrl = JWConfig.URL_IMAGE_BASE + posterPath
        JWServices.RequestImage(url: imgUrl, onSuccess: { data in
            self.imageData = data
        }) {
            print("GET IMAGE DATA FAILED")
        }
    }
}
