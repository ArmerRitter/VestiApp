//
//  NewsFilterViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 11.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol NewsFilterViewModelType {
    
    var onBackScreen: (() -> Void)? { get }
    var selectedCategories: [String] { get }
    func numberOfItems() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryCellViewModelType?
}


class NewsFilterViewModel: NewsFilterViewModelType {
    
    
    var categories = ["75 лет Победы","Авто","В мире","Культура","Медицина","Оборона и безопасность","Общество","Политика","Происшествия","Спорт","Экономика","Hi-Tech"]
    
    var selectedCategories: [String] {
        return UserDefaults.standard.value(forKey: "selectedCategories") as? [String] ?? [String()]
    }
    
    
    var onBackScreen: (() -> Void)?
    
    func numberOfItems() -> Int {
        return categories.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CategoryCellViewModelType? {
       
        let category = categories[indexPath.row]
        
        let isSelected = selectedCategories.contains(category) ? true : false
        
        let cellViewModel = CategoryCellViewModel(category: category, isSelected: isSelected)
    
        
        return cellViewModel
    }
    
}
