//
//  BNError.swift
//  TMDBapp
//
//  Created by 1 on 13.01.2022.
//

import Foundation

enum BNError: Error {
    case parsingError
    case noData
    case headersError
    case errorWithMessage(code: Int, message: String)
}
