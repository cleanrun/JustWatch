//
//  TMDBPeople.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation
import SwiftyJSON

class TMDBPeople: NSObject {
    var ID: Int = 0
    var imdbID: Int = 0
    var name: String = ""
    var alsoKnownAs: String = ""
    var gender: Int = 0
    var birthday: String = ""
    var placeOfBirth: String = ""
    var adult: Bool = false
    var deathday: String = ""
    var biography: String = ""
    var profilePath: String = ""
    
    override init() {
        // Empty constructor
    }
    
    init(with data: JSON) {
        ID = data["id"].intValue
        imdbID = data["imdb_id"].intValue
        name = data["name"].stringValue
        alsoKnownAs = data["also_known_as"].stringValue
        gender = data["gender"].intValue
        birthday = data["birthday"].stringValue
        placeOfBirth = data["place_of_birth"].stringValue
        adult = data["adult"].boolValue
        deathday = data["deathday"].stringValue
        biography = data["biography"].stringValue
        profilePath = data["profile_path"].stringValue
    }
}
