//
//  NewsDetailsViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 13.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol NewsDetailsViewModelType {
    var newsImage: Box<UIImage?> { get set }
    var newsTitle: Box<String> { get }
    var newsText: Box<String> { get }
    func getImage(imageURL: String)
    init(news: News, networkService: NetworkServiceProtocol)
}


class NewsDetailsViewModel: NewsDetailsViewModelType {
    
    private var news: News
    var networkService: NetworkServiceProtocol
    
    var newsImage: Box<UIImage?> = Box(nil)
    
    var newsTitle: Box<String> {
        return Box(news.title)
    }
    
    var newsText: Box<String> {
        return Box(news.fullText)
    }
    
    func getImage(imageURL: String) {
        networkService.getImage(url: imageURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                    self.newsImage.value = UIImage(named: "default_Image")!
                case .success(let image):
                    self.newsImage.value = image!
               }
            }
        }
    }
    
    required init(news: News, networkService: NetworkServiceProtocol) {
        self.news = news
        self.networkService = networkService
        getImage(imageURL: news.imageURL)
    }
    
}
