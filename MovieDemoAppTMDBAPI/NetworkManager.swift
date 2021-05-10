//
//  NetworkManager.swift
//  MovieDemoAppTMDBAPI
//
//  Created by Erem Karalar on 3.05.2021.
//

import Foundation
import Alamofire

enum NetworkManagerError: Error {
  case badResponse(URLResponse?)
  case badData
  case badLocalUrl
}

fileprivate struct APIResponse: Codable {
  let results: [Movie]
}

class NetworkManager {
  
  static var shared = NetworkManager()
  
    var images = NSCache<NSString, NSData>()
  
  let session: URLSession
  
  init() {
    let config = URLSessionConfiguration.default
    session = URLSession(configuration: config)
  }
  
    
    func getMovies(name:String,completion: @escaping ([Movie]?, Error?) -> (Void)) {
        let accessKey = "b148f6d9dfd3238df04d11edb3d3dfad"
        let baseURL = "https://api.themoviedb.org/3/search/movie?api_key=" + accessKey + "&query=" + name
        
    
        let requestURL = URL(string: baseURL)!
        
        AF.request(requestURL).responseJSON { data in
            print(data)
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data.data!)
              completion(response.results, nil)
            } catch let error {
              completion(nil, error)
            }
            
        }
        
    }
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
      if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
       
        completion(imageData as Data, nil)
        return
      }
      
      let task = session.downloadTask(with: imageURL) { localUrl, response, error in
        if let error = error {
          completion(nil, error)
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
          completion(nil, NetworkManagerError.badResponse(response))
          return
        }
        
        guard let localUrl = localUrl else {
          completion(nil, NetworkManagerError.badLocalUrl)
          return
        }
        
        do {
          let data = try Data(contentsOf: localUrl)
          self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
          completion(data, nil)
        } catch let error {
          completion(nil, error)
        }
      }
      
      task.resume()
    }
    
    func image(post: Movie, completion: @escaping (Data?, Error?) -> (Void)) {
//        let url = URL(resolvingAliasFileAt: post.posterURL)
//      download(imageURL: url, completion: completion)
        
        do {
            let url = try URL(resolvingAliasFileAt: post.posterURL)
          download(imageURL: url, completion: completion)
          
        } catch let error {
          completion(nil, error)
        }
      }
    }
      
    
    

