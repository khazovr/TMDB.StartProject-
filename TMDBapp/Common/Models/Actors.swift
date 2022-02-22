//
//  Actors.swift
//  TMDBapp
//
//  Created by 1 on 13.01.2022.
//

import Foundation

struct PopularActor: BaseModelProtocol {
    let page : Int
    let actors : [Actors]
    let totalPages : Int
    let totalResults : Int
    
    enum CodingKeys: String, CodingKey {
        
        case page,
             actors = "results",
             totalPages = "total_pages",
             totalResults = "total_results"
    }
}

struct Actors : BaseModelProtocol {
    let adult : Bool
    let gender : Int
    let id : Int
    let knownFor : [KnownFor]
    let knownForDepartment : String
    let name : String
    let popularity : Double
    let profilePath : String
    
    enum CodingKeys: String, CodingKey {
        
        case adult,
             gender,
             id,
             knownFor = "known_for",
             knownForDepartment = "known_for_department",
             name,
             popularity,
             profilePath = "profile_path"
    }
}

struct KnownFor : BaseModelProtocol {
    let backdropPath : String
    let firstAirDate : String
    let genreIds : [Int]
    let id : Int
    let mediaType : String
    let name : String
    let originCountry : [String]
    let originalLanguage : String
    let originalName : String
    let overview : String
    let posterPath : String
    let voteAverage : Double
    let voteCount : Int
    
    enum CodingKeys: String, CodingKey {
        
        case backdropPath = "backdrop_path",
             firstAirDate = "first_air_date",
             genreIds = "genre_ids",
             id = "id",
             mediaType = "media_type",
             name,
             originCountry = "origin_country",
             originalLanguage = "original_language",
             originalName = "original_name",
             overview,
             posterPath = "poster_path",
             voteAverage = "vote_average",
             voteCount = "vote_count"
    }
}
