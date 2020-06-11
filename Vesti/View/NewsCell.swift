//
//  MainTableViewCell.swift
//  Vesti
//
//  Created by Yuriy Balabin on 09.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    weak var viewModel: NewsCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            self.textLabel?.text = viewModel.title
            self.detailTextLabel?.text = viewModel.pubDate
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.numberOfLines = 4
        self.detailTextLabel?.textColor = .gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
