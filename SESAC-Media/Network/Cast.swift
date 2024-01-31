//
//  Cast.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import Foundation

struct CastModel: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
}
