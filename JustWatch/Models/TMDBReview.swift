//
//  TMDBReview.swift
//  JustWatch
//
//  Created by Marchell on 13/02/21.
//

import Foundation
import SwiftyJSON

class TMDBReview: NSObject {
    var ID: String = ""
    var author: String = ""
    var authorDetails: TMDBAuthor = TMDBAuthor()
    var content: String = ""
    var createdAt: String = ""
    var url: String = ""
    var mediaID: Int = 0
    var mediaTitle: String = ""
    var mediaType: String = ""
    
    override init() {
        // Empty constructor
    }
    
    init(with data: JSON) {
        ID = data["id"].stringValue
        author = data["author"].stringValue
        authorDetails = TMDBAuthor(with: data["author_details"])
        content = data["content"].stringValue
        createdAt = data["created_at"].stringValue
        url = data["url"].stringValue
        mediaID = data["media_id"].intValue
        mediaTitle = data["media_title"].stringValue
        mediaType = data["media_type"].stringValue
    }
}

class TMDBAuthor: NSObject {
    var name: String = ""
    var username: String = ""
    var avatarPath: String = ""
    var rating: Int = 0
    
    override init() {
        // Empty constructor
    }
    
    init(with data: JSON) {
        name = data["name"].stringValue
        username = data["username"].stringValue
        avatarPath = data["avatar_path"].stringValue
        rating = data["rating"].intValue
    }
}
