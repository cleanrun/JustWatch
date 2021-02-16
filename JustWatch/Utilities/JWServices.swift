//
//  JWServices.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class JWServices {
    
    /**
        Start of TMDB URLs
     */
    
    // MARK: Movies URL
    static let URL_MOVIES_GET_DETAILS: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_MOVIES_GET_ALTERNATIVE_TITLES: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)/alternative_titles?api_key=\(JWConfig.API_KEY)" }
    static let URL_MOVIES_GET_CREDITS: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)/credits?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_MOVIES_GET_IMAGES: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)/images?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_MOVIES_GET_KEYWORDS: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)/keywords?api_key=\(JWConfig.API_KEY)" }
    static let URL_MOVIES_GET_RELEASE_DATES: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)/release_dates?api_key=\(JWConfig.API_KEY)" }
    static let URL_MOVIES_GET_REVIEWS: (String, String) -> (String) = { (id, page) in JWConfig.URL_BASE + "movie/\(id)/reviews?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_SIMILIAR_MOVIES: (String) -> (String) = { id in JWConfig.URL_BASE + "movie/\(id)/similar?api_key=\(JWConfig.API_KEY)&language=en-US&page=1" }
    static let URL_MOVIES_GET_LATEST = JWConfig.URL_BASE + "movie/latest?api_key=\(JWConfig.API_KEY)&language=en-US"
    static let URL_MOVIES_GET_NOW_PLAYING: (String) -> (String) = { page in JWConfig.URL_BASE + "movie/now_playing?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_POPULAR: (String) -> (String) = { page in JWConfig.URL_BASE + "movie/popular?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_TOP_RATED: (String) -> (String) = { page in JWConfig.URL_BASE + "movie/top_rated?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_MOVIES_GET_UPCOMING: (String) -> (String) = { page in JWConfig.URL_BASE + "movie/upcoming?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    
    // MARK: TV Shows URL
    static let URL_TV_GET_DETAILS: (String) -> (String) = { id in JWConfig.URL_BASE + "tv/\(id)?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_TV_GET_ALTERNATIVE_TITLE: (String) -> (String) = { id in JWConfig.URL_BASE + "tv/\(id)/alternative_titles?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_TV_GET_CREDITS: (String) -> (String) = { id in JWConfig.URL_BASE + "tv/\(id)/credits?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_TV_GET_IMAGES: (String) -> (String) = { id in JWConfig.URL_BASE + "tv/\(id)/images?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_TV_GET_KEYWORDS: (String) -> (String) = { id in JWConfig.URL_BASE + "tv/\(id)/keywords?api_key=\(JWConfig.API_KEY)" }
    static let URL_TV_GET_REVIEWS: (String, String) -> (String) = { (id, page) in JWConfig.URL_BASE + "tv/\(id)/reviews?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_SIMILIAR: (String, String) -> (String) = { (id, page) in JWConfig.URL_BASE + "tv/\(id)/similar?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_LATEST = JWConfig.URL_BASE + "tv/latest?api_key=\(JWConfig.API_KEY)&language=en-US"
    static let URL_TV_GET_AIRING_TODAY: (String) -> (String) = { page in JWConfig.URL_BASE + "tv/airing_today?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)"}
    static let URL_TV_GET_ON_THE_AIR: (String) -> (String) = { page in JWConfig.URL_BASE + "tv/on_the_air?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_POPULAR: (String) -> (String) = { page in JWConfig.URL_BASE + "tv/popular?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    static let URL_TV_GET_TOP_RATED: (String) -> (String) = { page in JWConfig.URL_BASE + "tv/top_rated?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    
    // MARK: TV Seasons URL
    static let URL_SEASONS_GET_DETAILS: (String, String) -> (String) = { (id, season) in JWConfig.URL_BASE + "tv/\(id)/season/\(season)?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_SEASONS_GET_CREDITS: (String, String) -> (String) = { (id, season) in JWConfig.URL_BASE + "tv/\(id)/season/\(season)/credits?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_SEASONS_GET_IMAGES: (String, String) -> (String) = { (id, season) in JWConfig.URL_BASE + "tv/\(id)/season/\(season)/images?api_key=\(JWConfig.API_KEY)&language=en-US" }
    
    // MARK: TV Episodes URL
    static let URL_EPISODES_GET_DETAILS: (String, String, String) -> (String) = { (id, season, episode) in JWConfig.URL_BASE + "tv/\(id)/season/\(season)/episode/{episode_number}?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_EPISODES_GET_CREDITS: (String, String, String) -> (String) = { (id, season, episode) in JWConfig.URL_BASE + "tv/\(id)/season/\(season)/episode/{episode_number}/credits?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_EPISODES_GET_IMAGES: (String, String, String) -> (String) = { (id, season, episode) in JWConfig.URL_BASE + "tv/\(id)/season/\(season)/episode/{episode_number}/images?api_key=\(JWConfig.API_KEY)" }
    
    // MARK: People URL
    static let URL_PEOPLE_GET_DETAILS: (String) -> (String) = { id in JWConfig.URL_BASE + "person/\(id)?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_PEOPLE_GET_MOVIE_CREDITS: (String) -> (String) = { id in JWConfig.URL_BASE + "person/\(id)/movie_credits?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_PEOPLE_GET_TV_CREDITS: (String) -> (String) = { id in JWConfig.URL_BASE + "person/\(id)/tv_credits?api_key=\(JWConfig.API_KEY)&language=en-US" }
    static let URL_PEOPLE_GET_IMAGES: (String) -> (String) = { id in JWConfig.URL_BASE + "person/\(id)images?api_key=\(JWConfig.API_KEY)" }
    static let URL_PEOPLE_GET_LATEST = JWConfig.URL_BASE + "person/latest?api_key=\(JWConfig.API_KEY)&language=en-US"
    static let URL_PEOPLE_GET_POPULAR: (String) -> (String) = { page in JWConfig.URL_BASE + "person/popular?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)" }
    
    // MARK: Reviews URL
    static let URL_REVIEWS_GET_DETAILS: (String) -> (String) = { id in JWConfig.URL_BASE + "review/\(id)?api_key=\(JWConfig.API_KEY)" }
    
    // MARK: Search URL
    static let URL_SEARCH_GET_COLLECTIONS: (String, String) -> (String) = { (query, page) in JWConfig.URL_BASE + "search/collection?api_key=\(JWConfig.API_KEY)&language=en-US&query=\(query)&page=\(page)" }
    static let URL_SEARCH_GET_KEYWORDS: (String, String) -> (String) = { (query, page) in JWConfig.URL_BASE + "search/keyword?api_key=\(JWConfig.API_KEY)&query=\(query)&page=\(page)" }
    static let URL_SEARCH_GET_MOVIES: (String, String) -> (String) = { (query, page) in JWConfig.URL_BASE + "search/movie?api_key=\(JWConfig.API_KEY)&language=en-US&query=\(query)&page=\(page)&include_adult=false" }
    static let URL_SEARCH_GET_PEOPLE: (String, String) -> (String) = { (query, page) in JWConfig.URL_BASE + "search/person?api_key=\(JWConfig.API_KEY)&language=en-US&query=\(query)&page=\(page)&include_adult=false" }
    static let URL_SEARCH_GET_TV_SHOWS: (String, String) -> (String) = { (query, page) in JWConfig.URL_BASE + "search/tv?api_key=\(JWConfig.API_KEY)&language=en-US&page=\(page)&query=\(query)&include_adult=false" }
    
    /**
        End of TMDB URLs
     */
    
    static var manager: Session!
    
    class func Request(url: String, onSuccess: @escaping (JSON) -> Void, onFailure: @escaping (TMDBError) -> Void) {
        if manager == nil {
            let urlConfig = URLSessionConfiguration.default
            urlConfig.timeoutIntervalForRequest = JWConfig.RTO_INTERVAL
            manager = Session(configuration: urlConfig)
        }
        print("-url: \n\(url)")
        let request = manager.request(url, method: HTTPMethod.get, encoding: URLEncoding.default)
        request.responseJSON { response in
            switch response.result {
            case .success(let values):
                let data = JSON(values)
                print("-response: \n\(data)")
                switch response.response?.statusCode {
                case 200:
                    onSuccess(data)
                case 401:
                    let error = TMDBError(success: data["success"].boolValue, statusCode: data["status_code"].intValue, statusMessage: data["status_message"].stringValue)
                    onFailure(error)
                case 404:
                    let error = TMDBError(success: data["success"].boolValue, statusCode: data["status_code"].intValue, statusMessage: data["status_message"].stringValue)
                    onFailure(error)
                default:
                    let error = TMDBError(success: data["success"].boolValue, statusCode: data["status_code"].intValue, statusMessage: data["status_message"].stringValue)
                    onFailure(error)
                }
            case .failure(let values):
                let data = JSON(values)
                print("-response: \n\(data)")
                let error = TMDBError(success: data["success"].boolValue, statusCode: data["status_code"].intValue, statusMessage: data["status_message"].stringValue)
                onFailure(error)
            }
        }
    }
    
    class func RequestImage(url: String, onSuccess: @escaping (Data) -> Void, onFailure: @escaping () -> Void) {
        if manager == nil {
            let urlConfig = URLSessionConfiguration.default
            urlConfig.timeoutIntervalForRequest = JWConfig.RTO_INTERVAL
            manager = Session(configuration: urlConfig)
        }
        //print("-image url: \n\(url)")
        let request = manager.request(url, method: HTTPMethod.get, encoding: URLEncoding.default)
        request.response { response in
            switch response.result {
            case .success(let values):
                switch response.response?.statusCode {
                case 200:
                    onSuccess(values!)
                case 404:
                    onFailure()
                default:
                    onFailure()
                }
            case .failure(_):
                onFailure()
            }
        }
    }
    
}
