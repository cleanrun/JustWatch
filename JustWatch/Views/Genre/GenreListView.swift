//
//  GenreListView.swift
//  JustWatch
//
//  Created by Marchell on 03/03/21.
//

import SwiftUI

// MARK: Main View
struct GenreListView: View {
    
    var genreType: SearchType
    @StateObject private var viewModel = GenreListVM()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                FDDivider(height: 50)
                
                HStack {
                    JWSearchField(width: geometry.size.width/1.15, placeholder: JWConfig.WORDING_SEARCH_PLACEHOLDER, textValue: $viewModel.searchQuery) {
                        if genreType == .movie {
                            viewModel.getMovieGenres()
                        } else if genreType == .tv {
                            viewModel.getTVGenres()
                        }
                    }
                }
                
                FDDivider(height: 20)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        if genreType == .movie {
                            ForEach(viewModel.movieGenres, id: \.self) { genre in
                                GenreCell(genreCode: genre, genreType: .movie) {
                                    // Go to genre movie list
                                }
                            }
                        } else if genreType == .tv {
                            ForEach(viewModel.tvGenres, id: \.self) { genre in
                                GenreCell(genreCode: genre, genreType: .tv) {
                                    // Go to genre tv list
                                }
                            }
                        }
                    }
                }
            }.frame(width: geometry.size.width)
        }.edgesIgnoringSafeArea(.all)
    }
}

// MARK: Preview Provider
struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GenreListView(genreType: .movie)
    }
}

// MARK: View Model
class GenreListVM: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var movieGenres = JWConfig.MOVIE_GENRE_ALL
    @Published var tvGenres = JWConfig.TV_GENRE_ALL
    
    func getMovieGenres() {
        if searchQuery != "" {
            movieGenres = JWConfig.MOVIE_GENRE_ALL.filter { movie in
                return movie.toMovieGenre().contains(searchQuery)
            }
        } else {
            movieGenres = JWConfig.MOVIE_GENRE_ALL
        }
    }
    
    func getTVGenres() {
        if searchQuery != "" {
            tvGenres = JWConfig.TV_GENRE_ALL.filter { tv in
                return tv.toTVGenre().contains(searchQuery)
            }
        } else {
            tvGenres = JWConfig.TV_GENRE_ALL
        }
    }
}
