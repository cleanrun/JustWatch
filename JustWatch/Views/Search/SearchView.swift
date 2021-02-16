//
//  SearchView.swift
//  JustWatch
//
//  Created by Marchell on 16/02/21.
//

import SwiftUI

// MARK: Main View
struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewVM()
    
    @State private var searchType: SearchType = .movie
    @State private var isMovie: Bool = true
    @State private var isTV: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Color.SAPPHIRE
                        .frame(width: geometry.size.width, height: 160)
                        .cornerRadiusWithEachCorner(40, corners: [.bottomRight, .bottomLeft])
                    
                    VStack {
                        FDDivider(height: 25)
                        
                        JWSearchField(width: geometry.size.width/1.15, placeholder: JWConfig.WORDING_SEARCH_PLACEHOLDER, textValue: $viewModel.searchQuery) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { viewModel.performSearch(self.searchType) }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        JWPill(text: "Movie", textSize: 18, isActive: $isMovie) { withAnimation { movieTypeAction() }}
                        JWPill(text: "TV Shows", textSize: 18, isActive: $isTV) { withAnimation { tvTypeAction() }}
                    }.padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
                    
                    ScrollView {
                        LazyVStack {
                            if searchType == .movie {
                                ForEach(viewModel.movieResults, id: \.ID) { item in
                                    SearchResultCell(viewModel: SearchResultCellVM(title: item.title, voteAverage: item.voteAverage, posterPath: item.posterPath, genreIDs: item.genreIDs), searchType: .movie)
                                }
                            } else {
                                ForEach(viewModel.tvResults, id: \.ID) { item in
                                    SearchResultCell(viewModel: SearchResultCellVM(title: item.name, voteAverage: item.voteAverage, posterPath: item.posterPath, genreIDs: item.genreIDs), searchType: .tv)
                                }
                            }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 8, bottom: 30, trailing: 8))
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    private func movieTypeAction() {
        self.searchType = .movie
        self.isMovie = true
        self.isTV = false
        if viewModel.searchQuery != "" {
            viewModel.searchMovie(page: 1)
        }
    }
    
    private func tvTypeAction() {
        self.searchType = .tv
        self.isMovie = false
        self.isTV = true
        if viewModel.searchQuery != "" {
            viewModel.searchTV(page: 1)
        }
    }
}

// MARK: Preview Provider
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

// MARK: View Model
class SearchViewVM: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var movieResults = [TMDBMovie]()
    @Published var tvResults = [TMDBTVSeries]()
    
    func searchMovie(page: Int) {
        if page == 1 {
            movieResults.removeAll()
        }
        
        JWServices.Request(url: JWServices.URL_SEARCH_GET_MOVIES(searchQuery, "\(page)"), onSuccess: { response in
            let results = response["results"].arrayValue
            for result in results {
                let movie = TMDBMovie(with: result)
                self.movieResults.append(movie)
            }
        }) { error in
            print("ERROR GETTING MOVIE DATA:: \(error.statusMessage)")
        }
    }
    
    func searchTV(page: Int) {
        if page == 1 {
            tvResults.removeAll()
        }
        
        JWServices.Request(url: JWServices.URL_SEARCH_GET_TV_SHOWS(searchQuery, "\(page)"), onSuccess: { response in
            let results = response["results"].arrayValue
            for result in results {
                let tv = TMDBTVSeries(with: result)
                self.tvResults.append(tv)
            }
        }) { error in
            print("ERROR GETTING TV DATA:: \(error.statusMessage)")
        }
    }
    
    func performSearch(_ type: SearchType) {
        if searchQuery != "" {
            if type == .movie {
                searchMovie(page: 1)
            } else {
                searchTV(page: 1)
            }
        }
    }
}
