//
//  NetworkManager.swift
//  ios-movie-pedia
//
//  Created by Goo on 1/26/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func tmdb<ResponseType: Decodable>(
        _ request: TMDBRequest,
        _ responseT: ResponseType.Type,
        completionHandler: @escaping (ResponseType) -> Void,
        failHandler: @escaping (TMDBStatusCode) -> Void
    ) {
        AF.request(
            request.endpoint,
            method: request.method,
            parameters: request.parameters,
            headers: request.header
        )
        .validate(statusCode: 200...299)
        .responseDecodable(of: responseT) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
                    
            case .failure(_):
                guard let data = response.data else {
                    failHandler(TMDBStatusCode(0))
                    return
                }
                
                do {
                    let err = try JSONDecoder().decode(TMDBError.self, from: data)
                    failHandler(TMDBStatusCode(err.status_code))
                } catch {
                    print("catch")
                    failHandler(TMDBStatusCode(0))
                }
            }
        }
    }
}
