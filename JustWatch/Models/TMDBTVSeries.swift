//
//  TMDBTVSeries.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation
import SwiftyJSON

class TMDBTVSeries: NSObject {
    var ID: Int = 0
    var name: String = ""
    var inProduction: Bool = false
    var originalName: String = ""
    var originalLanguage: String = ""
    var firstAirDate: String = ""
    var overview: String = ""
    var status: String = ""
    var tagline: String = ""
    var type: String = ""
    var popularity: Double = 0.0
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
    var numberOfSeasons: Int = 0
    var numberOfEpisodes: Int = 0
    var posterPath: String = ""
    var backdropPath: String = ""
    var genreIDs = [String]()
    var genres = [TMDBGenre]()
    var networks = [TMDBProductionCompany]()
    var productionCompanies = [TMDBProductionCompany]()
    var seasons = [TMDBTVSeason]()
    var createdBy = [String]()
    
    override init() {
        // Empty contructor
    }
    
    init(with data: JSON) {
        ID = data["id"].intValue
        name = data["name"].stringValue
        inProduction = data["in_production"].boolValue
        originalName = data["original_name"].stringValue
        originalLanguage = data["original_language"].stringValue
        firstAirDate = data["first_air_date"].stringValue
        overview = data["overview"].stringValue
        status = data["status"].stringValue
        tagline = data["tagline"].stringValue
        type = data["type"].stringValue
        popularity = data["popularity"].doubleValue
        voteAverage = data["vote_average"].doubleValue
        voteCount = data["vote_count"].intValue
        numberOfSeasons = data["number_of_seasons"].intValue
        numberOfEpisodes = data["number_of_episodes"].intValue
        posterPath = data["poster_path"].stringValue
        backdropPath = data["backdrop_path"].stringValue
        
        let genreIDArray = data["genre_ids"].arrayValue
        let genresArray = data["genres"].arrayValue
        let productionCompaniesArray = data["production_companies"].arrayValue
        let seasonsArray = data["seasons"].arrayValue
        let createdByArray = data["created_by"].arrayValue
        let networksArray = data["networks"].arrayValue
        
        for id in genreIDArray {
            let genreID = id.stringValue
            genreIDs.append(genreID)
        }
        
        for genreData in genresArray {
            let genre = TMDBGenre(with: genreData)
            genres.append(genre)
        }
        
        for networkData in networksArray {
            let network = TMDBProductionCompany(with: networkData)
            networks.append(network)
        }
        
        for companyData in productionCompaniesArray {
            let company = TMDBProductionCompany(with: companyData)
            productionCompanies.append(company)
        }
        
        for seasonData in seasonsArray {
            let season = TMDBTVSeason(with: seasonData)
            seasons.append(season)
        }
        
        for creator in createdByArray {
            let creatorName = creator["name"].stringValue
            createdBy.append(creatorName)
        }
    }
}

class TMDBTVSeason: NSObject {
    var ID: Int = 0
    var _ID: String = ""
    var airDate: String = ""
    var name: String = ""
    var overview: String = ""
    var posterPath: String = ""
    var seasonNumber: Int = 0
    var episodes = [TMDBTVEpisode]()
    
    override init() {
        // Empty constructor
    }
    
    init(with data: JSON) {
        ID = data["id"].intValue
        _ID = data["_id"].stringValue
        airDate = data["air_date"].stringValue
        name = data["name"].stringValue
        overview = data["overview"].stringValue
        posterPath = data["poster_path"].stringValue
        seasonNumber = data["season_number"].intValue
        
        let episodesArray = data["episodes"].arrayValue
        for episodeData in episodesArray {
            let episode = TMDBTVEpisode(with: episodeData)
            episodes.append(episode)
        }
    }
    
}

class TMDBTVEpisode: NSObject {
    var ID: Int = 0
    var name: String = ""
    var airDate: String = ""
    var episodeNumber: Int = 0
    var seasonNumber: Int = 0
    var productionCode: String = ""
    var overview: String = ""
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
    
    override init() {
        // Empty Constructor
    }
    
    init(with data: JSON) {
        ID = data["id"].intValue
        name = data["name"].stringValue
        airDate = data["air_date"].stringValue
        episodeNumber = data["episode_number"].intValue
        seasonNumber = data["season_number"].intValue
        productionCode = data["production_code"].stringValue
        overview = data["overview"].stringValue
        voteAverage = data["vote_average"].doubleValue
        voteCount = data["vote_count"].intValue
    }
}
