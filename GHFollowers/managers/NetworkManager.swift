//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/8/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

// escaping closure
// https://medium.com/@diveshsinghjbp/escaping-in-swift-5-448775b288
// https://developer.github.com/v3/users/followers/

class NetworkManager {
    static let intance = NetworkManager()
    private let baseUrl = "https://api.github.com"
    private let cache = NSCache<NSString, UIImage>()
    private init() {
    }
    
    public func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "/users/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.error1))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.error2))
                return;
            }
            guard let data = data else {
                completed(.failure(.error3))
                return;
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print(data)
                let followers = try decoder.decode([Follower].self, from: data);
                completed(.success(followers))
            } catch {
                print(error)
                completed(.failure(.exceptionThrown))
            }
        }
        task.resume()
    }
    public func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        // I disagee with this approace
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let cacheKey = NSString(string: urlString);
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil {
                completed(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil)
                return
            }
            guard let data = data else {
                completed(nil)
                return
            }
            guard let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            DispatchQueue.main.async {
                self.cache.setObject(image, forKey: cacheKey)
                completed(image)
            }
        }
        task.resume()
    }
    public func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "/users/\(username)"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.error1))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.error2))
                return;
            }
            guard let data = data else {
                completed(.failure(.error3))
                return;
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print(data)
                let user = try decoder.decode(User.self, from: data);
                completed(.success(user))
            } catch {
                print(error)
                completed(.failure(.exceptionThrown))
            }
        }
        task.resume()
    }
}

