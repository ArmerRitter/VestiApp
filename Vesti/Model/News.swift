//
//  RssModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


struct News: Equatable {
    
    var title: String
    var pubDate: String
    var imageURL: String
    var category: String
    var fullText: String
}
