//
//  VestiListViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol NewsListViewModelType: class {
    
    var newsList: [News] { get }
    var filtredNewsList: [News] { get }
    var filterdResultIsNullFlag: Bool { get set }
    var updateNewsFlag: Box<Bool> { get set }
    var onSelectFilter: (() -> Void)? { get }
    var onSelectNewsDetails: ((News) -> Void)? { get }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType?
    func getNews()
    func filterNews()
    init(networkService: NetworkServiceProtocol)
}


class NewsListViewModel: NewsListViewModelType {
    
    
    var newsList = [News]()
    var filtredNewsList = [News]()
    var filterdResultIsNullFlag = false
    
    var networkService: NetworkServiceProtocol
    
    var updateNewsFlag: Box<Bool> = Box(false)
   
    var onSelectFilter: (() -> Void)?
    var onSelectNewsDetails: ((News) -> Void)?
    
    //Selected categories in filter
    var selectedCategories: [String]? {
    return UserDefaults.standard.value(forKey: "selectedCategories") as? [String] ?? nil
    }
    
    func numberOfItems() -> Int {
        if filterdResultIsNullFlag {
            return 0
        }
        
        return filtredNewsList.isEmpty ? newsList.count : filtredNewsList.count
    }
    
    func filterNews() {
        
        guard let selectedCategories = selectedCategories,       selectedCategories.count > 0 else {
            filtredNewsList = [News]()
            updateNewsFlag.value.toggle()
            return
        }
        
        filtredNewsList = newsList.filter { selectedCategories.contains($0.category) }
        
        if filtredNewsList.isEmpty {
           filterdResultIsNullFlag = true
        }
        updateNewsFlag.value.toggle()
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType? {
        let news: News
        
        if !filtredNewsList.isEmpty {
           news = filtredNewsList[indexPath.row]
        } else {
            news = newsList[indexPath.row]
        }
       
        
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
                    self.filterNews()
                    self.updateNewsFlag.value.toggle()
                    
                }
                
            }
        }
    }
    
    required init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getNews()
    }
    
}
