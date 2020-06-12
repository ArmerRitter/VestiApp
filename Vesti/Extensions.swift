//
//  Extensions.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


extension String {
    
   func removeSpacingPrefix() -> String {
        
        var countSpacing = 0
        
        for char in self {
            if char == " " {
                countSpacing += 1
            } else {
                break
            }
        }
        
    return String(self.dropFirst(countSpacing))
    }
    
    
}

//func setupHeaderTableView() {
//
//      let bottomLineView = UIView()
//      bottomLineView.backgroundColor = #colorLiteral(red: 0, green: 0.5843137255, blue: 0.8549019608, alpha: 1)
//      bottomLineView.translatesAutoresizingMaskIntoConstraints = false
//
//      headerTableView.addSubview(resetButton)
//      headerTableView.addSubview(titleHeaderTableView)
//      headerTableView.addSubview(bottomLineView)
//
//     resetButton.centerYAnchor.constraint(equalTo: headerTableView.centerYAnchor, constant: 5).isActive = true
//      resetButton.trailingAnchor.constraint(equalTo: headerTableView.trailingAnchor, constant: -10).isActive = true
//      resetButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
//     resetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//     titleHeaderTableView.centerXAnchor.constraint(equalTo: headerTableView.centerXAnchor).isActive = true
//      titleHeaderTableView.centerYAnchor.constraint(equalTo: headerTableView.centerYAnchor).isActive = true
//
//      bottomLineView.leftAnchor.constraint(equalTo: headerTableView.leftAnchor).isActive = true
//      bottomLineView.rightAnchor.constraint(equalTo: headerTableView.rightAnchor).isActive = true
//      bottomLineView.bottomAnchor.constraint(equalTo: headerTableView.bottomAnchor).isActive = true
//      bottomLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
//
//
//  }
