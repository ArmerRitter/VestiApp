//
//  VestiListViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol NewsListViewModelType: class {
    
    var update: Box<Bool> { get set }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType?
    func getNews()
    init(networkService: NetworkServiceProtocol)
}


class NewsListViewModel: NewsListViewModelType {
    
    
    var newsList = [News]()
    var networkService: NetworkServiceProtocol
    
    var update: Box<Bool> = Box(false)
    
    func numberOfItems() -> Int {
        return newsList.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType? {
        
        let news = newsList[indexPath.row]
        
        let cellViewModel = NewsCellViewModel(news: news)
        return cellViewModel
    }
    
    func getNews() {
        networkService.getNews { result in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    print(error)
                    
                case .success(let newsList):
                    
                    guard let newsList = newsList else { return }
                
                    self.newsList = newsList
                    self.update.value.toggle()
                }
                
            }
        }
    }
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getNews()
    }
    
}
