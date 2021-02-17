//
//  TVTrendingCell.swift
//  JustWatch
//
//  Created by Marchell on 14/02/21.
//

import SwiftUI

// MARK: Main View
struct TVTrendingCell: View {
    
    @ObservedObject var viewModel: TVTrendingCellVM
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
                    Text(viewModel.name)
                        .padding(EdgeInsets(top: 10, leading: 18, bottom: 0, trailing: 0))
                        .foregroundColor(.white)
                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 25).weight(.bold))
                        .lineLimit(3)
                    Spacer()
                }
                HStack {
                    Text(viewModel.firstAirDate)
                        .padding(EdgeInsets(top: 1, leading: 18, bottom: 0, trailing: 0))
                        .foregroundColor(.gray)
                        .font(Font.custom(JWConfig.FONT_ARIAL, size: 14))
                        .lineLimit(1)
                    Spacer()
                }
                Spacer()
                HStack {
                    ForEach(viewModel.genres, id: \.self) { genre in
                        JWPill(text: genre.toTVGenre(), textSize: 10)
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
struct TVTrendingCell_Previews: PreviewProvider {
    static var previews: some View {
        TVTrendingCell(viewModel: TVTrendingCellVM(TMDBTVSeries())).previewLayout(PreviewLayout.sizeThatFits)
    }
}

// MARK: View Model
class TVTrendingCellVM: ObservableObject {
    private var tv: TMDBTVSeries
    
    var ID: Int { tv.ID }
    var name: String { tv.name }
    var firstAirDate: String { tv.firstAirDate }
    var genres: [String] { tv.genreIDs }
    var backdropPath: String { tv.backdropPath }
    
    @Published var imageData = Data()
    
    init(_ tv: TMDBTVSeries) {
        self.tv = tv
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

