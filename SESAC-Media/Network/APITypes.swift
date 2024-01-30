//
//  APITypes.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import Foundation

enum APITypes: String, CaseIterable {
    case trend
    case topRated
    case popular
    
    var url: String {
        switch self {
        case .trend:
            return "https://api.themoviedb.org/3/trending/tv/week?language=ko-KO"
        case .topRated:
            return "https://api.themoviedb.org/3/tv/top_rated?language=ko-KO"
        case .popular:
            return "https://api.themoviedb.org/3/tv/popular?language=ko-KO"
        }
    }
    
    var sectionNumber: Int {
        switch self {
        case .trend:
            return 0
        case .topRated:
            return 1
        case .popular:
            return 2
        }
    }
}
