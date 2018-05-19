//
//  Concentration.swift
//  Concentration
//
//  Created by Anna Garcia on 5/15/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var score = 0
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    var selectedIndex = Set<Int>()
    var lastIndexWasSelected = false
    
    func chooseCard(at index: Int){
        let cardWasPreviouslySelected = selectedIndex.contains(index)
        if !cards[index].isMatched {
            // only flip cards that are visible
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                // 2 cards are face up, check if cards match
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    if lastIndexWasSelected {
                        // add extra to account for subtracting earlier
                        score += 3
                    } else {
                        score += 2
                    }
                }else {
                    // no match
                    if cardWasPreviouslySelected {score -= 1}
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = nil
            } else {
                // one card is selected, turn down other cards and set this card
                if cardWasPreviouslySelected { score -= 1 }
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = index
                lastIndexWasSelected = cardWasPreviouslySelected
            }
        }
        
        selectedIndex.insert(index)
    }
    
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func shuffleCards() {
        for _ in 0..<cards.count {
            // sort seems better than .swap()
            cards.sort(by: {_,_ in arc4random() > arc4random()})
        }
    }
}
