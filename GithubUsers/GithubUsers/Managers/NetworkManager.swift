//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import UIKit

// Basic native way to make network calls (foundational knowledge)
class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getGenericJSONData<T: Decodable>(for username: String, with endpointExt: String?, completed: @escaping (Result<T, GUError>) -> Void) {
        var endpoint = baseURL + "\(username)"
        if let endpointExt = endpointExt { endpoint += endpointExt }
        
        guard let  url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                
                let genericData = try decoder.decode(T.self, from: data)
                completed(.success(genericData))
                
            } catch {
                completed(.failure(.invalidData))
                return
            }
        }
        
        task.resume()
    }
    
    // completion handler (closure): @ escaping (return Follower array, return error String)
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GUError>) -> Void) {
        // Create the url that we will be trying to access data from
        let endpointExt = "/followers?per_page=100&page=\(page)"
        getGenericJSONData(for: username, with: endpointExt, completed: completed)
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GUError>) -> Void) {
        getGenericJSONData(for: username, with: nil, completed: completed)
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
              error == nil,
              let response = response as? HTTPURLResponse, response.statusCode == 200,
              let data = data,
              let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
    
}
