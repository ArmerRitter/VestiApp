//
//  NetworkService.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit


protocol NetworkServiceProtocol {
    func getNews(completion: @escaping (Result<[News]?,Error>) -> Void)
    func getImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void)
}

enum NetworkingError: String, Error {
    case urlError = "url could not be configured"
}

class NetworkService: NetworkServiceProtocol {
    
  //fetching News data
    func getNews(completion: @escaping (Result<[News]?, Error>) -> Void) {
        
        guard let rssURL = URL(string: "http://www.vesti.ru/vesti.rss")
            else { fatalError(NetworkingError.urlError.rawValue) }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        configuration.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        
        URLSession(configuration: configuration).dataTask(with: rssURL) { (data: Data?, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
             guard let data = data else { return }
            
            let news = ParserService().parse(data: data)
            completion(.success(news))
           
            
        }.resume()
        
    }
    
 //fetching Image
    func getImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
         
         guard let imageURL = URL(string: url) else {
            completion(.failure(NetworkingError.urlError))
            return
         }
    
         URLSession.shared.dataTask(with: imageURL)  { (data: Data?, response, error) in
                  
                 if let error = error {
                     completion(.failure(error))
                     return
                 }
            
                 guard let data = data, let image = UIImage(data: data) else { return }
                     
                 completion(.success(image))
                     
                 }.resume()
     }
    
    
}


