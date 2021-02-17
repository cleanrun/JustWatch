//
//  SearchResultCell.swift
//  JustWatch
//
//  Created by Marchell on 16/02/21.
//

import SwiftUI

// MARK: Main View
struct SearchResultCell: View {
    
    @ObservedObject var viewModel: SearchResultCellVM
    var searchType: SearchType
    var onTapGesture: () -> Void = {}
    
    var body: some View {
        VStack {
            Spacer()
            ZStack(alignment: .leading) {
                Color.white.cornerRadius(18)
                
                HStack(alignment: .top) {
                    Image(uiImage: (UIImage(data: viewModel.imageData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_POSTER))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 130)
                        .cornerRadius(15)
                        .padding([.leading], 10)
                        .clipped()
                        .offset(y: -20)
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.title)
                            .font(Font.custom(JWConfig.FONT_ARIAL, size: 18).weight(.semibold))
                            .foregroundColor(.SAPPHIRE)
                            .padding(EdgeInsets(top: 13, leading: 8, bottom: 0, trailing: 0))
                        
                        HStack {
                            Image(systemName: "hand.thumbsup.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .foregroundColor(.DANUBE)
                            Text("\(String(format: "%.1f", viewModel.voteAverage)) / 10")
                                .font(Font.custom(JWConfig.FONT_ARIAL, size: 12).weight(.semibold))
                                .foregroundColor(.DANUBE)
                        }.padding(EdgeInsets(top: 1, leading: 8, bottom: 0, trailing: 0))
                        
                        Spacer()
                        
                        HStack {
                            ForEach(viewModel.genreIDs.prefix(3), id: \.self) { genre in
                                JWPill(text: searchType == .movie ? genre.toMovieGenre() : genre.toTVGenre(), textSize: 10)
                            }
                        }.padding(EdgeInsets(top: 0, leading: 8, bottom: 20, trailing: 0))

                    }
                }
                
            }//.frame(height: 100)
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .cornerRadius(15)
            .shadow(radius: 9)
        }.frame(minWidth: 100, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
        .padding(13)
        .onTapGesture {
            onTapGesture()
        }
    }
}

// MARK: Preview Provider
struct SearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultCell(viewModel: SearchResultCellVM(title: "Dark Phoenix", voteAverage: 9.3, posterPath: "", genreIDs: ["28", "12"]), searchType: .movie).previewLayout(.sizeThatFits)
    }
}

// MARK: View Model
class SearchResultCellVM: ObservableObject {
    var title: String
    var voteAverage: Double
    var genreIDs: [String]
    var posterPath: String
    
    @Published var imageData = Data()
    
    init(title: String, voteAverage: Double, posterPath: String, genreIDs: [String]) {
        self.title = title
        self.voteAverage = voteAverage
        self.posterPath = posterPath
        self.genreIDs = genreIDs
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

enum SearchType {
    case movie
    case tv
}
