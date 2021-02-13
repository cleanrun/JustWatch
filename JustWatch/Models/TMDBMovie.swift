//
//  TMDBMovie.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation
import SwiftyJSON

class TMDBMovie: NSObject {
    
    var ID: Int = 0
    var imdbID: Int = 0
    var title: String = ""
    var originalTitle: String = ""
    var originalLanguage: String = ""
    var overview: String = ""
    var budget: Int = 0
    var popularity: Double = 0.0
    var posterPath: String = ""
    var releaseDate: String = ""
    var status: String = ""
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
    var productionCompanies = [TMDBProductionCompany]()
    var genres = [TMDBGenre]()
    
    override init() {
        // Empty constructor
    }
    
    init(with data: JSON) {
        ID = data["id"].intValue
        imdbID = data["imdb_id"].intValue
        title = data["title"].stringValue
        originalTitle = data["original_title"].stringValue
        originalLanguage = data["original_language"].stringValue
        overview = data["overview"].stringValue
        budget = data["budget"].intValue
        popularity = data["popularity"].doubleValue
        posterPath = data["poster_path"].stringValue
        releaseDate = data["release_date"].stringValue
        status = data["status"].stringValue
        voteAverage = data["vote_average"].doubleValue
        voteCount = data["vote_count"].intValue
        
        let productionCompaniesArray = data["production_companies"].arrayValue
        for companyData in productionCompaniesArray {
            let company = TMDBProductionCompany(with: companyData)
            productionCompanies.append(company)
        }
        
        let genresArray = data["genres"].arrayValue
        for genreData in genresArray {
            let genre = TMDBGenre(with: genreData)
            genres.append(genre)
        }
    }
}

class TMDBProductionCompany: NSObject {
    var ID: Int = 0
    var name: String = ""
    var logoPath: String = ""
    var originCountry: String = ""
    
    init(with data: JSON) {
        ID = data["id"].intValue
        name = data["name"].stringValue
        logoPath = data["logo_path"].stringValue
        originCountry = data["origin_country"].stringValue
    }
}

class TMDBGenre: NSObject {
    var ID: Int = 0
    var name: String = ""
    
    init(with data: JSON) {
        ID = data["id"].intValue
        name = data["name"].stringValue
    }
}
