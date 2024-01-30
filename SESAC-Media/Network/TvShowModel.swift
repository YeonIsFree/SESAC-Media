//
//  TopRatedModel.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import Foundation

struct TvShowModel: Decodable {
    let results: [TvShow]
}

struct TvShow: Decodable {
    let id: Int
    let name: String
    let overview: String
    let poster_path: String?
}
