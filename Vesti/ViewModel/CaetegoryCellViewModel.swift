//
//  CaetegoryCellViewModel.swift
//  Vesti
//
//  Created by Yuriy Balabin on 12.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


protocol CategoryCellViewModelType: class {
    var isSelected: Bool { get set }
    var category: String { get set }
}


class CategoryCellViewModel: CategoryCellViewModelType {
   
    
   
   
    var category: String
    
    var isSelected: Bool
    
    
    
    init(category: String, isSelected: Bool) {
        self.category = category
        self.isSelected = isSelected
    }
    
    
}
