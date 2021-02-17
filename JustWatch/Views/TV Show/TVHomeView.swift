//
//  TVHomeView.swift
//  JustWatch
//
//  Created by Marchell on 14/02/21.
//

import SwiftUI
import NavigationStack

// MARK: Main View
struct TVHomeView: View {
    
    @StateObject private var viewModel = TVHomeVM()
    @EnvironmentObject private var navStack: NavigationStack
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.STRIKEMASTER
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
                                ForEach(viewModel.popularTV, id: \.ID) { popular in
                                    TVTrendingCell(viewModel: TVTrendingCellVM(popular)) {
                                        self.navStack.push(TVDetailView(viewModel: TVDetailVM(id: popular.ID)))
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
                                .foregroundColor(Color.STRIKEMASTER)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                            
                            JWBorderPill(text: "See All", textSize: 12)
                                .padding([.trailing], 18)
                        }.frame(width: geometry.size.width)
                        
                        HStack {
                            ForEach(viewModel.randomGenres, id: \.self) { genre in
                                JWGenreCell(genre: genre, type: .tv)
                                    .frame(width: geometry.size.width/5)
                            }
                        }.frame(width: geometry.size.width, height: 100, alignment: .center)
                        
                        /**
                         End of Genres Section
                        */
                        
                        // --------------------------------------------------------------- //
                        
                        /**
                         Start of On The Air Section
                        */
                        
                        HStack {
                            Text("On The Air")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 20).weight(.semibold))
                                .foregroundColor(Color.STRIKEMASTER)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                            
                            JWBorderPill(text: "See All", textSize: 12)
                                .padding([.trailing], 18)
                        }.frame(width: geometry.size.width)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.onTheAirTV, id: \.ID) { onTheAir in
                                    TVPosterCell(viewModel: TVPosterCellVM(onTheAir)) {
                                        self.navStack.push(TVDetailView(viewModel: TVDetailVM(id: onTheAir.ID)))
                                    }
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 18, bottom: 6, trailing: 0))
                        .frame(height: 400)
                        
                        /**
                         End of On The Air Section
                        */
                        
                        // --------------------------------------------------------------- //
                        
                        /**
                         Start of Top Rated Section
                        */
                        
                        HStack {
                            Text("Top Rated")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 20).weight(.semibold))
                                .foregroundColor(Color.STRIKEMASTER)
                                .padding(EdgeInsets(top: 10, leading: 18, bottom: 10, trailing: 0))
                            Spacer()
                            
                            JWBorderPill(text: "See All", textSize: 12)
                                .padding([.trailing], 18)
                        }.frame(width: geometry.size.width)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(viewModel.topRatedTV, id: \.ID) { topRated in
                                    TVPosterCell(viewModel: TVPosterCellVM(topRated)) {
                                        self.navStack.push(TVDetailView(viewModel: TVDetailVM(id: topRated.ID)))
                                    }
                                }
                            }
                        }.padding(EdgeInsets(top: 0, leading: 18, bottom: 6, trailing: 0))
                        .frame(height: 400)
                        
                        /**
                         End of Top Rated Section
                        */
                        
                        FDDivider(height: 100)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

// MARK: Preview Provider
struct TVHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TVHomeView()
    }
}

// MARK: View Model
class TVHomeVM: ObservableObject {
    @Published var popularTV = [TMDBTVSeries]()
    @Published var onTheAirTV = [TMDBTVSeries]()
    @Published var topRatedTV = [TMDBTVSeries]()
    @Published var randomGenres = [String]()
    
    init() {
        getPopularTV()
        getOnTheAirTV()
        getTopRatedTV()
        getRandomGenres()
    }
    
    func getPopularTV() {
        let popularURL = JWServices.URL_TV_GET_POPULAR("1")
        JWServices.Request(url: popularURL, onSuccess: { response in
            let data = response["results"].arrayValue
            for popular in data {
                let tv = TMDBTVSeries(with: popular)
                self.popularTV.append(tv)
            }
        }, onFailure: { failResponse in
            print(failResponse.statusMessage)
        })
    }
    
    func getOnTheAirTV() {
        let npURL = JWServices.URL_TV_GET_ON_THE_AIR("1")
        JWServices.Request(url: npURL, onSuccess: { response in
            let data = response["results"].arrayValue
            for np in data {
                let tv = TMDBTVSeries(with: np)
                self.onTheAirTV.append(tv)
            }
        }, onFailure: { failResponse in
            print(failResponse.statusMessage)
        })
    }
    
    func getTopRatedTV() {
        let topRatedURL = JWServices.URL_TV_GET_TOP_RATED("1")
        JWServices.Request(url: topRatedURL, onSuccess: { response in
            let data = response["results"].arrayValue
            for topRated in data {
                let tv = TMDBTVSeries(with: topRated)
                self.topRatedTV.append(tv)
            }
        }, onFailure: { failResponse in
            print(failResponse.statusMessage)
        })
    }
    
    func getRandomGenres() {
        for _ in 1...4 {
            randomGenres.append(JWConfig.TV_GENRE_ALL.randomElement()!)
        }
    }
}
