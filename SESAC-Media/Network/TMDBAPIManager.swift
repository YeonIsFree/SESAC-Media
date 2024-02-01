//
//  TMDBAPIManager.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import Foundation
import Alamofire

// [식판 돌려쓸 수 있는 애들]
// Popular, Trending, Top Rated, Recommand --> 드라마 리스트

// Detail --> 드라마

// Cast  --> 캐스팅

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    // 드라마 리스트
    func fetchSeriesList(api: TMDBAPI, completionHandler: @escaping ([TVSeries]) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: TVSeriesModel.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success.results)
                completionHandler(success.results)
            case .failure(let failure):
                print("Network Fail", failure)
            }
        }
    }
    
    // 드라마
    func fetchSeries(api: TMDBAPI, completionHandler: @escaping (TVSeries) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   headers: api.header)
        .responseDecodable(of: TVSeries.self) { response in
            switch response.result {
            case .success(let success):
//                dump(success)
                completionHandler(success)
            case .failure(let failure):
                print("Network Fail", failure)
            }
        }
    }
    
    // 캐스트
    func fetchCast(api: TMDBAPI, completionHandler: @escaping ([Cast]) -> Void) {
        AF.request(api.endpoint, headers: api.header)
            .responseDecodable(of: CastModel.self) { response in
                switch response.result {
                case .success(let success):
//                    dump(success.cast)
                    completionHandler(success.cast)
                case .failure(let failure):
                    print("Network Fail", failure)
                }
            }
    }
}
