//
//  MovieHomeView.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import SwiftUI
import NavigationStack

// MARK: Main View
struct MovieHomeView: View {
    
    @StateObject private var viewModel = MovieHomeVM()
    @EnvironmentObject private var navStack: NavigationStack
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.SAPPHIRE
                    .frame(width: geometry.size.width, height: 300)
                    .cornerRadiusWithEachCorner(100, corners: [.bottomRight])
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        FDDivider(height: 50)
                        
                        /**
                         Start of Popular Section
                        */
                        
                        HStack {
                            Text("Popular")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 20).weight(.semibold))
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                        }.frame(width: geometry.size.width)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.popularMovies, id: \.ID) { popular in
                                    MovieTrendingCell(viewModel: MovieTrendingCellVM(popular)) {
                                        self.navStack.push(MovieDetailView(viewModel: MovieDetailVM(id: popular.ID)))
                                    }
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 18, bottom: 6, trailing: 0))
                        .frame(height: 200)
                        
                        /**
                         End of Popular Section
                        */
                        
                        // --------------------------------------------------------------- //
                        
                        /**
                         Start of Genres Section
                        */
                        
                        HStack {
                            Text("Genres")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 20).weight(.semibold))
                                .foregroundColor(.SAPPHIRE)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                            
                            JWBorderPill(text: "See All", textSize: 12, tapGesture: { self.navStack.push(GenreListView(genreType: .movie)) })
                                .padding([.trailing], 18)
                        }.frame(width: geometry.size.width)
                        
                        HStack {
                            ForEach(viewModel.randomGenres, id: \.self) { genre in
                                JWGenreCell(genre: genre, type: .movie)
                                    .frame(width: geometry.size.width/5)
                            }
                        }.frame(width: geometry.size.width, height: 100, alignment: .center)
                        
                        /**
                         End of Genres Section
                        */
                        
                        // --------------------------------------------------------------- //
                        
                        /**
                         Start of Now Playing Section
                        */
                        
                        HStack {
                            Text("Now Playing")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 20).weight(.semibold))
                                .foregroundColor(.SAPPHIRE)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                            
                            JWBorderPill(text: "See All", textSize: 12)
                                .padding([.trailing], 18)
                        }.frame(width: geometry.size.width)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.nowPlayingMovies, id: \.ID) { nowPlaying in
                                    MoviePosterCell(viewModel: MoviePosterCellVM(nowPlaying)) {
                                        self.navStack.push(MovieDetailView(viewModel: MovieDetailVM(id: nowPlaying.ID)))
                                    }
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 18, bottom: 6, trailing: 0))
                        .frame(height: 400)
                        
                        /**
                         End of Now Playing Section
                        */
                        
                        // --------------------------------------------------------------- //
                        
                        /**
                         Start of Upcoming Section
                        */
                        
                        HStack {
                            Text("Upcoming")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 20).weight(.semibold))
                                .foregroundColor(.SAPPHIRE)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                            
                            JWBorderPill(text: "See All", textSize: 12)
                                .padding([.trailing], 18)
                        }.frame(width: geometry.size.width)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.upcomingMovies, id: \.ID) { upcoming in
                                    MoviePosterCell(viewModel: MoviePosterCellVM(upcoming)) {
                                        self.navStack.push(MovieDetailView(viewModel: MovieDetailVM(id: upcoming.ID)))
                                    }
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 18, bottom: 6, trailing: 0))
                        .frame(height: 400)
                        
                        /**
                         End of Upcoming Section
                        */
                        
                        FDDivider(height: 100)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

// MARK: Preview Provider
struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}

// MARK: View Model
class MovieHomeVM: ObservableObject {
    @Published var popularMovies = [TMDBMovie]()
    @Published var nowPlayingMovies = [TMDBMovie]()
    @Published var upcomingMovies = [TMDBMovie]()
    @Published var randomGenres = [String]()
    
    init() {
        getPopularMovies()
        getNowPlayingMovies()
        getUpcomingMovies()
        getRandomGenres()
    }
    
    func getPopularMovies() {
        let popularURL = JWServices.URL_MOVIES_GET_POPULAR("1")
        JWServices.Request(url: popularURL, onSuccess: { response in
            let data = response["results"].arrayValue
            for popular in data {
                let movie = TMDBMovie(with: popular)
                self.popularMovies.append(movie)
            }
        }, onFailure: { failResponse in
            print(failResponse.statusMessage)
        })
    }
    
    func getNowPlayingMovies() {
        let npURL = JWServices.URL_MOVIES_GET_NOW_PLAYING("1")
        JWServices.Request(url: npURL, onSuccess: { response in
            let data = response["results"].arrayValue
            for np in data {
                let movie = TMDBMovie(with: np)
                self.nowPlayingMovies.append(movie)
            }
        }, onFailure: { failResponse in
            print(failResponse.statusMessage)
        })
    }
    
    func getUpcomingMovies() {
        let upcomingURL = JWServices.URL_MOVIES_GET_UPCOMING("1")
        JWServices.Request(url: upcomingURL, onSuccess: { response in
            let data = response["results"].arrayValue
            for upcoming in data {
                let movie = TMDBMovie(with: upcoming)
                self.upcomingMovies.append(movie)
            }
        }, onFailure: { failResponse in
            print(failResponse.statusMessage)
        })
    }
    
    func getRandomGenres() {
        for _ in 1...4 {
            randomGenres.append(JWConfig.MOVIE_GENRE_ALL.randomElement()!)
        }
    }
}
