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
        failHandler: @escaping () -> Void
    ) {
        AF.request(
            request.endpoint,
            method: request.method,
            parameters: request.parameters,
            headers: request.header
        ).responseDecodable(of: responseT) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
                    
            case .failure(_):
                print(response.response?.statusCode)
                print(response.error?.errorDescription)
                failHandler()
            }
        }
    }
}
