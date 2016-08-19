//
//  Movie.swift
//  test
//
//  Created by Mohamed Alsadek on 7/29/16.
//  Copyright © 2016 Mohamed Alsadek. All rights reserved.
//

import UIKit
import SwiftyJSON


struct MovieParams {
    static let overview = "overview"
    static let title = "title"
    static let video = "video"
    static let releaseDate = "release_date"
    static let originalLanguage = "original_language"
    static let popularity = "popularity"
    static let posterPath = "poster_path"
    static let originalTitle = "original_title"
    static let id = "id"
    static let voteCount = "vote_count"
    static let adult = "adult"
    static let backdropPath = "backdrop_path"
    static let voteAverage = "vote_average"
}


class Movie: NSObject {
   
    /// Params
    var overview: String?
    var title: String?
    var video: Bool?
    var releaseDate: String?
    var originalLanguage: String?
    var popularity: Float?
    var posterPath: String?
    var originalTitle: String?
    var id: Int?
    var voteCount: Int?
    var adult: Bool?
    var backdropPath: String?
    var voteAverage: Float?
    
    
    /// Custom Initializer
     init(object:NSDictionary) {
        
        let json = JSON(object)
        
        overview = json[MovieParams.overview].string
        
        title = json[MovieParams.title].string
        
        video = json[MovieParams.video].boolValue
        
        releaseDate = json[MovieParams.releaseDate].string
        
        originalLanguage = json[MovieParams.originalLanguage].string
        
        popularity = json[MovieParams.popularity].floatValue
        
        posterPath = Constants.BaseApi.imageBaseURL + json[MovieParams.posterPath].string!
        
        originalTitle = json[MovieParams.originalTitle].string
        
        id = json[MovieParams.id].int
        
        voteCount = json[MovieParams.voteCount].int
        
        adult = json[MovieParams.adult].boolValue
        
        backdropPath = json[MovieParams.backdropPath].string
        
        voteAverage = json[MovieParams.voteAverage].floatValue
    }
    
}

