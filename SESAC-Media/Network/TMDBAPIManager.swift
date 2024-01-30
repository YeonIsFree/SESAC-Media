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
    
    func fetchData(type: APITypes, completionHandler: @escaping ([TvShow]) -> Void) {
        let url = type.url
        
        let headers: HTTPHeaders = ["Authorization" : APIKey.tmdb]
        
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
}
