//
//  VestiListViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol NewsListViewModelType: class {
    
    var retrieveNewsFlag: Box<Bool> { get set }
    var onSelectFilter: (() -> Void)? { get set }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType?
    func getNews()
    init(networkService: NetworkServiceProtocol)
}


class NewsListViewModel: NewsListViewModelType {
    
    
    var newsList = [News]()
    var networkService: NetworkServiceProtocol
    
    var retrieveNewsFlag: Box<Bool> = Box(false)
    var onSelectFilter: (() -> Void)?
    
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
                    self.retrieveNewsFlag.value.toggle()
                    
                  
//                   for i in newsList {
//                       print(i.category)
//                    }
                }
                
            }
        }
    }
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getNews()
    }
    
}
