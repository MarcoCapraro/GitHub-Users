//
//  NetworkManager.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import Foundation

// Basic native way to make network calls (foundational knowledge)
class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    // completion handler (closure): @ escaping (return Follower array, return error String)
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        // Create the url that we will be trying to access data from
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // Ensure valid url, otherwise prompt error and return
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request. Please try again")
            return
        }
        
        // Now that we have a valid url, can then use it to retrieve information from API
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // If an error exists return that error, otherwise continue
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your internet connection")
                return
            }
            
            // (1st check) If the response isn't nil, set it as response;
            // (2nd check) Now that the response is not nil, If the response.statusCode == 200, you are good to go
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again")
                return
            }
            
            // Ensure data isn't nil, otherwise prompt error and return
            guard let data = data else {
                completed(nil, "The data received from the server is invalid. Please try again")
                return
            }
            
            // Use a do catch for handling errors from decoding data
            do {
                // Encoder takes our object and encodes it into data
                // Decoder takes data from server and decodes it into our object
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // Try to decode the retrieved data into an array of followers, otherwise go to catch
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
                
            // When the try fails, the catch block is executed
            } catch {
                completed(nil, "The data received from the server is invalid. Please try again")
                return
            }
        }
        
        // This starts the network call created above
        task.resume()
    }
}
