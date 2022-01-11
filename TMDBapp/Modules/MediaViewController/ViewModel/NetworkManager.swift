//
//  NetworkManager.swift
//  TMDBapp
//
//  Created by 1 on 11.01.2022.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func requestPopularActors(completion: @escaping(([Actor]) -> ())) {
        
        let url = Constants.network.defaultPath + Constants.requests.popularPerson + Constants.network.apiKey
        
        AF.request(url).responseJSON { responce in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(PopularPerson.self, from: responce.data!) {
                let actors = data.actors ?? []
                print(actors)
                completion(actors)
               
            }
        }
    }
}
