//
//  APICaller.swift
//  Netflix
//
//  Created by Rituraj on 06/08/22.
//

import Foundation

struct Constants {
    
    static let API_KEY = "b4665ddc478fee7b32ed3c2c4f868ee2"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeAPI_KEY = "AIzaSyABwErmFpWyZE5k5EINfKvaBIi4e8BRxeE"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
        guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void)  {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
        task.resume()
    
}
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
     
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
     
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
                            
    }
    
    func getToprated(completion: @escaping (Result<[Title], Error>) -> Void) {
     
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
        task.resume()
    }
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
        task.resume()
        
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
            completion(.success(results.results))
        } catch {
            completion(.failure(APIError.failedTogetData))
        }
    }
        task.resume()
        
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _, error in
            guard let data = data, error == nil else {return}
        
        
        do{
            let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
            completion(.success(results.items[0]))
            
        } catch {
            completion(.failure(error))
            print(error.localizedDescription)
        }
    }
        task.resume()
       
    }
    
    
  }
















