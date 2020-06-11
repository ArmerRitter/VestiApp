//
//  ArticleCellViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 11.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol NewsCellViewModelType: class {
    var title: String { get }
    var pubDate: String { get }
}


class NewsCellViewModel: NewsCellViewModelType {
   
   
    var news: News
    
    var title: String {
        return news.title
    }
    
    var pubDate: String {
        return news.pubDate
    }
    
    init(news: News) {
        self.news = news
    }
    
    
}
