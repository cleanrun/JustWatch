//
//  TVPosterCell.swift
//  JustWatch
//
//  Created by Marchell on 14/02/21.
//

import SwiftUI

// MARK: Main View
struct TVPosterCell: View {
    
    @ObservedObject var viewModel: TVPosterCellVM
    
    var body: some View {
        ZStack {
            Image(uiImage: (UIImage(data: viewModel.imageData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_POSTER))!)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }.frame(width: 200, height: 390, alignment: .center)
        .cornerRadius(25)
        .padding(5)
    }
}

// MARK: Preview Provider
struct TVPosterCell_Previews: PreviewProvider {
    static var previews: some View {
        TVPosterCell(viewModel: TVPosterCellVM(TMDBTVSeries())).previewLayout(PreviewLayout.sizeThatFits)
    }
}

// MARK: View Model
class TVPosterCellVM: ObservableObject {
    private var tv: TMDBTVSeries
    
    var ID: Int { tv.ID }
    var name: String { tv.name }
    var posterPath: String { tv.posterPath }
    
    @Published var imageData = Data()
    
    init(_ tv: TMDBTVSeries) {
        self.tv = tv
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
