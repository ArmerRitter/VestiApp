//
//  NewsFilterViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 11.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol NewsFilterViewModelType {
    func numberOfItems() -> Int
    func getCategories() -> [String]
}


class NewsFilterViewModel: NewsFilterViewModelType {
    
    
    var categories = ["75 лет Победы","Авто","В мире","Культура","Оборона и безопасность","Общество","Политика","Происшествия","Спорт","Экономика","Hi-Tech"]
    
    
    func numberOfItems() -> Int {
        return categories.count
    }
    
    func getCategories() -> [String] {
        return categories
    }
    
    
}
