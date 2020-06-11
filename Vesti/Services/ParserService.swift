//
//  ParserService.swift
//  Vesti
//
//  Created by Yuriy Balabin on 10.06.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation


class ParserService: NSObject {
   
    var title = String()
    var pubDate = String()
    var enclosure = String()
    var category = String()
    var fullText = String()
    
    var elementName = String()
    var foundCharacters = ""
    
    var newsList = [News]()
    
    func parse(data: Data) -> [News] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        
        return newsList
    }
    
   
    
}

extension ParserService: XMLParserDelegate {
   
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            self.title = String()
            self.pubDate = String()
            self.enclosure = String()
            self.category = String()
        }

        if elementName == "enclosure" {
            if let url = attributeDict["url"] {
                self.enclosure = url
            }
        }
        
        self.elementName = elementName
        
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        self.foundCharacters += string.trimmingCharacters(in: CharacterSet.newlines)
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "title" {
            self.title = self.foundCharacters.removeSpacingPrefix()
        }
        
        if elementName == "category" {
            self.category = self.foundCharacters.removeSpacingPrefix()
        }
        
        if elementName == "pubDate" {
            self.pubDate = self.foundCharacters.removeSpacingPrefix()
        }
        
        if elementName == "yandex:full-text" {
            self.fullText = self.foundCharacters.removeSpacingPrefix()
        }
        
        if elementName == "item" {
            let element = News(title: title, pubDate: pubDate, imageURL: enclosure, category: category, fullText: fullText)
            newsList.append(element)
        }
        self.foundCharacters = ""
    }
    
    
    
    
}
