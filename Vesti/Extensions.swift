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
