//
//  TMDBAPI.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/02/01.
//


// 여기서 네트워킹 요청 보낼 모든 준비를 하쟈

import Foundation
import Alamofire

enum TMDBAPI {
    case trend
    case topRated
    case popular
    case details(id: Int)
    case recommand(id: Int)
    case cast(id: Int)
    
    var header: HTTPHeaders {
        return ["Authorization" : APIKey.tmdb]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    static var baseImageURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    var endpoint: URL {
        switch self {
        case .trend:
            return URL(string: baseURL + "trending/tv/week?language=ko-KO")!
        case .topRated:
            return URL(string: baseURL + "tv/top_rated?language=ko-KO")!
        case .popular:
            return URL(string: baseURL + "tv/popular?language=ko-KO")!
        case .details(let id):
            return URL(string: baseURL + "tv/\(id)?language=ko-KR")!
        case .recommand(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations?language=ko-KR")!
        case .cast(let id):
            return URL(string: baseURL + "tv/\(id)/aggregate_credits")!
        }
    }
}


