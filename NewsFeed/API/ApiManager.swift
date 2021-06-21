//
//  ApiManager.swift
//  NewsFeed
//
//  Created by Nikita Entin on 12.06.2021.
//

import Foundation

final class ApiManager {
    private var path: String? = "https://k8s-stage.apianon.ru/posts/v1/posts?first=2"
    enum RequestType {
        case after
        case mostPopular
        case createdAt
    }
    
    func fetch<T: Codable>(string: String?, type: RequestType?, completion: @escaping (T) -> ()) {
        switch type {
        case .after:
            path = "https://k8s-stage.apianon.ru/posts/v1/posts?after=\(string ?? "")"
        case .mostPopular:
            path = "https://k8s-stage.apianon.ru/posts/v1/posts?orderBy=mostPopular"
        case .createdAt:
            path = "https://k8s-stage.apianon.ru/posts/v1/posts?orderBy=createdAt"
        default:
            break
        }
            guard let urlPath = path, let url = URL(string: urlPath) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object)
            } catch let error as NSError {
                print(error.userInfo)
            }
            }.resume()
    }
}

