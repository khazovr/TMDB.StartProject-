//
//  BaseResponse.swift
//  TMDBapp
//
//  Created by 1 on 13.01.2022.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var success: Bool
    var errorMessage: String?
    var errorCode: Int?
    var data: T
    
    enum CodingKeys: String, CodingKey {
        case success,
             errorMessage = "error_message",
             errorCode = "error_code",
             data
    }
}
