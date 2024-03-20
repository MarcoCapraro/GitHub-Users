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
    let decoder         = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy     = .convertFromSnakeCase
        decoder.dateDecodingStrategy    = .iso8601
    }
    
//    func getGenericJSONData<T: Decodable>(for username: String, with endpointExt: String?, completed: @escaping (Result<T, GUError>) -> Void) {
//        var endpoint = baseURL + "\(username)"
//        if let endpointExt = endpointExt { endpoint += endpointExt }
//        
//        guard let  url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder                     = JSONDecoder()
//                decoder.keyDecodingStrategy     = .convertFromSnakeCase
//                decoder.dateDecodingStrategy    = .iso8601
//                
//                let genericData = try decoder.decode(T.self, from: data)
//                completed(.success(genericData))
//                
//            } catch {
//                completed(.failure(.invalidData))
//                return
//            }
//        }
//        
//        task.resume()
//    }
    
    func getGenericJSONData<T: Decodable>(for username: String, with endpointExt: String?) async throws -> T {
        var endpoint = baseURL + "\(username)"
        if let endpointExt = endpointExt { endpoint += endpointExt }
        
        guard let  url = URL(string: endpoint) else { throw GUError.invalidUsername }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GUError.invalidResponse}
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw GUError.invalidData
        }
        
    }

    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpointExt = "/followers?per_page=100&page=\(page)"
        return try await getGenericJSONData(for: username, with: endpointExt)
    }
    
    func getUserInfo(for username: String) async throws -> User  {
        return try await getGenericJSONData(for: username, with: nil)
    }
    
    // Dont use throw keyword, only need an optional return result, no errors to handle
    func downloadImage(from urlString: String) async -> UIImage? {
        // Try to pull from cache otherwise download image
        let cacheKey    = NSString(string: urlString)
        if let image    = cache.object(forKey: cacheKey) { return image }
        guard let url   = URL(string: urlString) else { return nil }
        
        do {
            // Not in cache, uses url to get image and add it to the cache before returning
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
}
