//
//  MediaViewModel.swift
//  TMDBapp
//
//  Created by 1 on 13.01.2022.
//

import Foundation
import RealmSwift

struct ActorsViewModel {
    
    var name: String
    var posterImage: URL?
    var popularity: String
    
    init(actors: Actors) {
        self.name = actors.name
        self.posterImage = URL(string: Constants.network.defaultImagePath + actors.profilePath)
        self.popularity = String(format: "%ld", actors.popularity)
    }
}
