//
//  MovieDetailView.swift
//  JustWatch
//
//  Created by Marchell on 16/02/21.
//

import SwiftUI
import NavigationStack

// MARK: Main View
struct MovieDetailView: View {
    @EnvironmentObject private var navStack: NavigationStack
    @ObservedObject var viewModel: MovieDetailVM
    
    init(viewModel: MovieDetailVM) {
        self.viewModel = viewModel
        //UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image(uiImage: (UIImage(data: viewModel.backdropData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_BACKDROP))!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: 330)
                
                ScrollView(showsIndicators: false) {
                    VStack {
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
                                    Text(viewModel.title)
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 25).weight(.semibold))
                                        .foregroundColor(.SAPPHIRE)
                                        .padding([.top, .bottom], 12)
                                        .lineLimit(3)
                                    
                                    HStack {
                                        ForEach(viewModel.genres.prefix(2), id: \.ID) { genre in
                                            JWBorderPill(text: genre.name, textSize: 12, textColor: .SAPPHIRE, borderColor: .DANUBE)
                                        }
                                    }
                                }.padding([.leading], 10)
                                
                                Spacer()
                                    
                            }.padding([.leading, .trailing], 20)
                            
                            FDDivider(height: 20)
                            
                            HStack(spacing: 50) {
                                VStack {
                                    Text("Release Date")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 15))
                                        .foregroundColor(.gray)
                                        .padding([.bottom], 1)
                                    
                                    Text(viewModel.releaseDate)
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 18).weight(.semibold))
                                }
                                
                                VStack() {
                                    Text("Duration")
                                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 15))
                                        .foregroundColor(.gray)
                                        .padding([.bottom], 1)
                                    
                                    Text("\(viewModel.runtime)")
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
                                    .foregroundColor(.SAPPHIRE)
                                    .padding([.top, .bottom], 8)
                                
                                Text(viewModel.overview)
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 17))
                                    .foregroundColor(.gray)
                                
                                
                            }.padding([.leading, .trailing], 24)
                            
                            VStack(alignment: .leading) {
                                Text("Production Companies")
                                    .font(Font.custom(JWConfig.FONT_ARIAL, size: 23).weight(.semibold))
                                    .foregroundColor(.SAPPHIRE)
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
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailVM(id: 464052))
    }
}

// MARK: View Model
class MovieDetailVM: ObservableObject {
    @Published private var movie = TMDBMovie()
    
    var title: String { movie.title }
    var genres: [TMDBGenre] { movie.genres }
    var releaseDate: String { movie.releaseDate }
    var runtime: Int { movie.runtime }
    var voteAverage: Double { movie.voteAverage }
    var overview: String { movie.overview }
    var productionCompanies: [TMDBProductionCompany] { movie.productionCompanies }
    
    @Published var posterData = Data()
    @Published var backdropData = Data()
    
    init(id: Int) {
        getMovie(with: id) {
            self.getImages()
        }
    }
    
    private func getMovie(with id: Int, completion: @escaping () -> Void) {
        let movieUrl = JWServices.URL_MOVIES_GET_DETAILS("\(id)")
        JWServices.Request(url: movieUrl, onSuccess: { response in
            self.movie = TMDBMovie(with: response)
            completion()
        }) { error in
            print("ERROR GETTING MOVIE DATA:: \(error.statusMessage)")
        }
    }
    
    private func getImages() {
        let backdropUrl = JWConfig.URL_IMAGE_BASE + movie.backdropPath
        let posterUrl = JWConfig.URL_IMAGE_BASE + movie.posterPath
        
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
