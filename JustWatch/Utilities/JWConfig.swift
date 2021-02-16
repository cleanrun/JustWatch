//
//  JWConfig.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation

class JWConfig {
    
    // MARK: API Configurations
    static let URL_BASE = "https://api.themoviedb.org/3/"
    static let URL_IMAGE_BASE = "https://image.tmdb.org/t/p/w500"
    static let API_KEY = "e9325a84053f572e130d8028237ab315"
    
    static let RTO_INTERVAL: TimeInterval = 300
    
    // MARK: Colors
    static let COLOR_SAPPHIRE = "#33539E"
    static let COLOR_DANUBE = "#7FACD6"
    static let COLOR_LAVENDER_GRAY = "#BFB8DA"
    static let COLOR_LIGHT_ORCHID = "#E8B7D4"
    static let COLOR_STRIKEMASTER = "#A5678E"
    static let COLOR_LIGHT_GRAY = "#ECECF6"
    
    // MARK: Fonts
    static let FONT_ARIAL = "Arial"
    
    // MARK: Image Names
    static let IMG_PLACEHOLDER_MOVIE_POSTER = "placeholder_movie_poster"
    static let IMG_PLACEHOLDER_MOVIE_BACKDROP = "placeholder_movie_backdrop"
    
    // MARK: Movie Genres
    static let MOVIE_GENRE_ACTION = "28"
    static let MOVIE_GENRE_ADVENTURE = "12"
    static let MOVIE_GENRE_ANIMATION = "16"
    static let MOVIE_GENRE_COMEDY = "35"
    static let MOVIE_GENRE_CRIME = "80"
    static let MOVIE_GENRE_DOCUMENTARY = "99"
    static let MOVIE_GENRE_DRAMA = "18"
    static let MOVIE_GENRE_FAMILY = "10751"
    static let MOVIE_GENRE_FANTASY = "14"
    static let MOVIE_GENRE_HISTORY = "36"
    static let MOVIE_GENRE_HORROR = "27"
    static let MOVIE_GENRE_MUSIC = "10402"
    static let MOVIE_GENRE_MYSTERY = "9648"
    static let MOVIE_GENRE_ROMANCE = "10749"
    static let MOVIE_GENRE_SCIFI = "878"
    static let MOVIE_GENRE_TV_MOVIE = "10770"
    static let MOVIE_GENRE_THRILLER = "53"
    static let MOVIE_GENRE_WAR = "10752"
    static let MOVIE_GENRE_WESTERN = "37"
    
    static let MOVIE_GENRE_ALL = ["28", "12", "16", "35", "80", "99", "18", "10751", "14", "36", "27", "10402", "9648", "10749", "878", "10770", "53", "10752", "37"]
    
    // MARK: TV Genres
    static let TV_GENRE_ACTION_ADVENTURE = "10759"
    static let TV_GENRE_ANIMATION = "16"
    static let TV_GENRE_COMEDY = "35"
    static let TV_GENRE_CRIME = "80"
    static let TV_GENRE_DOCUMENTARY = "99"
    static let TV_GENRE_DRAMA = "18"
    static let TV_GENRE_FAMILY = "10751"
    static let TV_GENRE_KIDS  = "10762"
    static let TV_GENRE_MYSTERY = "9648"
    static let TV_GENRE_NEWS = "10763"
    static let TV_GENRE_REALITY = "10764"
    static let TV_GENRE_SCIFI_FANTASY = "10765"
    static let TV_GENRE_SOAP = "10766"
    static let TV_GENRE_TALK = "10767"
    static let TV_GENRE_WAR_POLITICS = "10768"
    static let TV_GENRE_WESTERN = "37"
    
    static let TV_GENRE_ALL = ["10759", "16", "35", "80", "99", "18", "10751", "10762", "9648", "10763", "10764", "10765", "10766", "10767", "10768", "37"]
    
    // MARK: Wordings
    static let WORDING_SEARCH_PLACEHOLDER = "Search here.."
}
