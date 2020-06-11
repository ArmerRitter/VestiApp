//
//  NetworkService.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol NetworkServiceProtocol {
    func getNews(completion: @escaping (Result<[News]?,Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    
    func getNews(completion: @escaping (Result<[News]?, Error>) -> Void) {
        
        guard let rssURL = URL(string: "https://www.vesti.ru/vesti.rss")
        else { fatalError("url could not be configured") }
        
        URLSession.shared.dataTask(with: rssURL) { (data: Data?, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
             guard let data = data, let content = String(data: data, encoding: .utf8) else { return }
            
            let news = ParserService().parse(data: data)
            completion(.success(news))
            
            
        }.resume()
        
    }
    
    
    
    
}
