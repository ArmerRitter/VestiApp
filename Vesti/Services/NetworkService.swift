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
            print(content)
            
        }.resume()
        
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage?,Error>) -> Void) {
         
         guard let imageURL = URL(string: url) else {
            let error = errorT.Err
            completion(.failure(error))
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

enum errorT: String, Error {
    case Err = "ete"
}
