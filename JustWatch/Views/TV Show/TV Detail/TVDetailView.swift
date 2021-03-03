//
//  TVDetailView.swift
//  JustWatch
//
//  Created by Marchell on 17/02/21.
//

import SwiftUI
import NavigationStack

// MARK: Main View
struct TVDetailView: View {
    @EnvironmentObject private var navStack: NavigationStack
    @ObservedObject var viewModel: TVDetailVM
    
    init(viewModel: TVDetailVM) {
        self.viewModel = viewModel
        //UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack {
                        GeometryReader { (proxy: GeometryProxy) in
                            if proxy.frame(in: .global).minY <= 0 {
                                Image(uiImage: (UIImage(data: viewModel.backdropData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_BACKDROP))!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.size.width, height: 330)
                            } else {
                                Image(uiImage: (UIImage(data: viewModel.backdropData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_BACKDROP))!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(y: -proxy.frame(in: .global).minY)
                                    .frame(width: proxy.size.width, height: 330 + proxy.frame(in: .global).minY)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            FDDivider(height: 20)
                            
                            HStack {
                                Image(uiImage: (UIImage(data: viewModel.posterData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_POSTER))!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 180)
                                    .cornerRadius(20)
                                    .clipped()
                                
                                VStack(alignment: .leading) {
                                    Text(viewModel.name)
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 25).weight(.semibold))
                                        .foregroundColor(.STRIKEMASTER)
                                        .padding([.top, .bottom], 12)
                                        .lineLimit(3)
                                    
                                    HStack {
                                        ForEach(viewModel.genres.prefix(2), id: \.ID) { genre in
                                            JWBorderPill(text: genre.name, textSize: 12, textColor: .STRIKEMASTER, borderColor: .LIGHT_ORCHID)
                                        }
                                    }
                                }.padding([.leading], 10)
                                
                                Spacer()
                                    
                            }.padding([.leading, .trailing], 20)
                            
                            FDDivider(height: 20)
                            
                            HStack(spacing: 50) {
                                VStack {
                                    Text("First Air Date")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 15))
                                        .foregroundColor(.gray)
                                        .padding([.bottom], 1)
                                    
                                    Text(viewModel.firstAirDate)
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 18).weight(.semibold))
                                }
                                
                                VStack() {
                                    Text("Episodes")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 15))
                                        .foregroundColor(.gray)
                                        .padding([.bottom], 1)
                                    
                                    Text("\(viewModel.numberOfEpisodes)")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 18).weight(.semibold))
                                }
                                
                                VStack() {
                                    Text("Rating")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 15))
                                        .foregroundColor(.gray)
                                        .padding([.bottom], 1)
                                    
                                    Text("\(String(format: "%.1f", viewModel.voteAverage)) / 10")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 18).weight(.semibold))
                                }
                            }.frame(width: geometry.size.width)
                            
                            VStack(alignment: .leading) {
                                Text("Overview")
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 23).weight(.semibold))
                                    .foregroundColor(.STRIKEMASTER)
                                    .padding([.top, .bottom], 8)
                                
                                Text(viewModel.overview)
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 17))
                                    .foregroundColor(.gray)
                                
                                
                            }.padding([.leading, .trailing], 24)
                            
                            VStack(alignment: .leading) {
                                Text("Seasons")
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 23).weight(.semibold))
                                    .foregroundColor(.STRIKEMASTER)
                                    .padding([.top, .bottom], 8)
                                
                                VStack {
                                    ForEach(viewModel.seasons, id: \.self) { season in
                                        VStack {
                                            HStack {
                                                Text(season.name)
                                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 15).weight(.semibold))
                                                    .foregroundColor(.gray)
                                                    .padding([.top], 8)
                                                
                                                Spacer()
                                                
                                                Image(systemName: "chevron.right")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 15, height: 15)
                                                    .foregroundColor(.gray)
                                            }.padding([.top, .bottom], 4)
                                            
                                            Divider().foregroundColor(.LIGHT_GRAY)
                                        }
                                    }
                                }
  
                            }.padding([.leading, .trailing], 24)
                            
                            VStack(alignment: .leading) {
                                Text("Networks")
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 23).weight(.semibold))
                                    .foregroundColor(.STRIKEMASTER)
                                    .padding([.top], 8)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.networks, id: \.ID) { network in
                                            ProductionCompanyCell(viewModel: ProductionCompanyCellVM(network))
                                        }
                                    }
                                }
                            }.frame(height: 250)
                            .padding([.leading], 24)
                            
                            VStack(alignment: .leading) {
                                Text("Production Companies")
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 23).weight(.semibold))
                                    .foregroundColor(.STRIKEMASTER)
                                    .padding([.top], 8)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.productionCompanies, id: \.ID) { company in
                                            ProductionCompanyCell(viewModel: ProductionCompanyCellVM(company))
                                        }
                                    }
                                }
                            }.frame(height: 250)
                            .padding([.leading], 24)
                            
                            FDDivider(height: 400)
                            
                        }.frame(width: geometry.size.width)
                        .background(Color.white)
                        .cornerRadiusWithEachCorner(50, corners: [.topLeft, .topRight])
                        .offset(y: 180)
                    }
                }
                
                HStack {
                    JWBackButton()
                    Spacer()
                }.padding(EdgeInsets(top: 50, leading: 25, bottom: 0, trailing: 0))
                
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

// MARK: Preview Provider
struct TVDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVDetailView(viewModel: TVDetailVM(id: 1396))
    }
}

// MARK: View Model
class TVDetailVM: ObservableObject {
    @Published private var tv = TMDBTVSeries()
    
    @Published var posterData = Data()
    @Published var backdropData = Data()
    
    var name: String { tv.name }
    var genres: [TMDBGenre] { tv.genres }
    var firstAirDate: String { tv.firstAirDate }
    var numberOfEpisodes: Int { tv.numberOfEpisodes }
    var numberOfSeasons: Int { tv.numberOfSeasons }
    var voteAverage: Double { tv.voteAverage }
    var overview: String { tv.overview }
    var seasons: [TMDBTVSeason] { tv.seasons }
    var networks: [TMDBProductionCompany] { tv.networks }
    var productionCompanies: [TMDBProductionCompany] { tv.productionCompanies }
    
    init(id: Int) {
        getMovie(with: id) {
            self.getImages()
        }
    }
    
    private func getMovie(with id: Int, completion: @escaping () -> Void) {
        let movieUrl = JWServices.URL_TV_GET_DETAILS("\(id)")
        JWServices.Request(url: movieUrl, onSuccess: { response in
            self.tv = TMDBTVSeries(with: response)
            completion()
        }) { error in
            print("ERROR GETTING MOVIE DATA:: \(error.statusMessage)")
        }
    }
    
    private func getImages() {
        let backdropUrl = JWConfig.URL_IMAGE_BASE + tv.backdropPath
        let posterUrl = JWConfig.URL_IMAGE_BASE + tv.posterPath
        
        JWServices.RequestImage(url: backdropUrl, onSuccess: { data in
            self.backdropData = data
        }) {
            print("GET BACKDROP DATA FAILED")
        }
        
        JWServices.RequestImage(url: posterUrl, onSuccess: { data in
            self.posterData = data
        }) {
            print("GET POSTER DATA FAILED")
        }
    }
}
