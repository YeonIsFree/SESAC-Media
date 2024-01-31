//
//  TMDBAPIManager.swift
//  SESAC-Media
//
//  Created by Seryun Chun on 2024/01/30.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    static let shared = TMDBAPIManager()
    
    let imageBaseURL = "https://image.tmdb.org/t/p/w500"
    
    let headers: HTTPHeaders = ["Authorization" : APIKey.tmdb]
    
    func fetchShowData(type: APITypes, completionHandler: @escaping ([TvShow]) -> Void) {
        let url = type.url
        
        AF.request(url, headers: headers)
            .responseDecodable(of: TvShowModel.self) { response in
                switch response.result {
                case .success(let success):
                    dump(success.results)
                    completionHandler(success.results)
                case .failure(let failure):
                    print("Network Fail", failure)
                }
            }
    }
    
    func fetchDetailData(completionHandler: @escaping (Detail) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/1668?language=ko-KR"
        AF.request(url, headers: headers)
            .responseDecodable(of: Detail.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print("Network Fail", failure)
                }
            }
    }
    
    func fetchRecommandData(completionHandler: @escaping ([TvShow]) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/1668/recommendations?language=ko-KR"
        AF.request(url, headers: headers)
            .responseDecodable(of: TvShowModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success.results)
                case .failure(let failure):
                    print("Network Fail", failure)
                }
            }
    }
    
    func fetchCast(completionHandler: @escaping ([Cast]) -> Void) {
        let url = "https://api.themoviedb.org/3/tv/1668/aggregate_credits"
        AF.request(url, headers: headers)
            .responseDecodable(of: CastModel.self) { response in
                switch response.result {
                case .success(let success):
                    dump(success.cast)
                    completionHandler(success.cast)
                case .failure(let failure):
                    print("Network Fail", failure)
                }
            }
    }
}
