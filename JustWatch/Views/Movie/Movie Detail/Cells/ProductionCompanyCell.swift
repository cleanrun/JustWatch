//
//  ProductionCompanyCell.swift
//  JustWatch
//
//  Created by Marchell on 16/02/21.
//

import SwiftUI

// MARK: Main View
struct ProductionCompanyCell: View {
    
    @ObservedObject var viewModel: ProductionCompanyCellVM
    
    var onTapGesture: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 13) {
            Image(uiImage: (UIImage(data: viewModel.imageData) ?? UIImage(named: JWConfig.IMG_PLACEHOLDER_MOVIE_POSTER))!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(15)
                .padding([.top], 16)
            
            Text(viewModel.name)
                .font(Font.custom(JWConfig.FONT_ARIAL, size: 12))
                .foregroundColor(.gray)
                .padding([.leading, .trailing], 10)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
        }.frame(width: 125, height: 170, alignment: .top)
        .background(Color.white.cornerRadius(15).shadow(radius: 8))
        .padding(8)
        .onTapGesture {
            onTapGesture()
        }
    }
}

// MARK: Preview Provider
struct ProductionCompanyCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductionCompanyCell(viewModel: ProductionCompanyCellVM(TMDBProductionCompany())).previewLayout(.sizeThatFits)
    }
}

// MARK: View Model
class ProductionCompanyCellVM: ObservableObject {
    private var productionCompany: TMDBProductionCompany
    var name: String { productionCompany.name }
    
    @Published var imageData: Data = Data()
    
    init(_ productionCompany: TMDBProductionCompany) {
        self.productionCompany = productionCompany
        getLogo()
    }
    
    func getLogo() {
        let imgUrl = JWConfig.URL_IMAGE_BASE + productionCompany.logoPath
        JWServices.RequestImage(url: imgUrl, onSuccess: { data in
            self.imageData = data
        }) {
            print("GET IMAGE DATA FAILED")
        }
    }

}
