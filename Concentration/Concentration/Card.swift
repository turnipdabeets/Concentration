//
//  Card.swift
//  Concentration
//
//  Created by Anna Garcia on 5/15/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import Foundation
/**
 a game card that contains the following var:
 - isFaceUp
 - isMatched
 - identifier
 */
struct Card: Hashable
{
    var hashValue: Int {
        return identifier
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifer() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifer()
    }
}
