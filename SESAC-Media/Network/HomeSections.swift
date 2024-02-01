//
//  TMDBAPISectionNumber.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//

import Foundation

// HomeViewController

enum HomeSections {
    case trend
    case topRated
    case popular
    
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
    
    var title: String {
        switch self {
        case .trend:
            return "Trend"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        }
    }
}



