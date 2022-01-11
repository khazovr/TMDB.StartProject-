//
//  MediaViewModel.swift
//  TMDBapp
//
//  Created by 1 on 11.01.2022.
//

import Foundation
import RealmSwift

class MediaViewModel {
    
    let realm = try? Realm()
    
    var actors: [Actor] = []
    
    func loadActors(completion: @escaping(() -> ())) {
        NetworkManager.shared.requestPopularActors { actors in
            self.actors = actors
            completion()
            print(actors)
        }
    }
}
