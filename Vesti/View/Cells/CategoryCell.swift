//
//  CategoryCell.swift
//  Vesti
//
//  Created by Yuriy Balabin on 12.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

 weak var viewModel: CategoryCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            self.textLabel?.text = viewModel.category
            
            if viewModel.isSelected {
                self.accessoryType = .checkmark
            } else {
                self.accessoryType = .none
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .checkmark
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

