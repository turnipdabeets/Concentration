//
//  ViewController.swift
//  Concentration
//
//  Created by Anna Garcia on 5/15/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {didSet { flipCountLabel.text = "Flip Count: \(flipCount)" }}
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            if !game.cards[cardNumber].isMatched { flipCount += 1 }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("card is not in cardButton array")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        // reset count
        flipCount = 0
        // reset game
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        // reset theme choices
        emojiChoices = theme.getRandomThemeIcons()
        // update view
        updateViewFromModel()
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    var theme = Theme()
    
    lazy var emojiChoices = theme.getRandomThemeIcons()

    var emoji = [Int: String]()

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

