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
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUp: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    foundIndex = (foundIndex == nil) ? index : nil
                }
            }
            return foundIndex
        }
        
        set {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = (flipDownIndex == newValue)
            }
        }
    }
    
    private var selectedIndex = Set<Int>()
    private var lastIndexWasSelected = false
    /// returns true if all cards have been matched
    var allCardsHaveBeenMatched: Bool {
        for index in cards.indices {
            if !cards[index].isMatched { return false }
        }
        return true
    }
    
    /**
     Choose a card at an index.
     Handles flip count, if a card is faced up, and matching of cards
     */
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): index is not in the cards")
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
            } else {
                // one card is selected, turn down other cards and set this card
                if cardWasPreviouslySelected { score -= 1 }
                indexOfOneAndOnlyFaceUp = index
                lastIndexWasSelected = cardWasPreviouslySelected
            }
        }
        
        selectedIndex.insert(index)
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentraation.init(numberOfPairsOfCards:\(numberOfPairsOfCards) you must have multiple pairs of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }
    
    private func shuffleCards() {
        for _ in 0..<cards.count {
            // sort seems better than .swap()
            cards.sort(by: {_,_ in arc4random() > arc4random()})
        }
    }
}
