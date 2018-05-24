//
//  ViewController.swift
//  Concentration
//
//  Created by Anna Garcia on 5/15/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet weak var finishedLabel: UILabel!
    private var flipCount = 0 { didSet { flipCountLabel.text = "Flip Count: \(flipCount)" } }
    private var scoreCount = 0 { didSet { scoreCountLabel.text = "Score: \(scoreCount)"} }
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else {
            print("card is not in cardButton array")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        // reset game
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        // reset theme choices
        emojiChoices = theme.getRandomThemeIcons()
        // update view
        updateViewFromModel()
    }
    
    private func updateViewFromModel(){
        flipCount = game.flipCount
        scoreCount = game.score
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
        finishedLabel.textColor = game.allCardsHaveBeenMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        finishedLabel.text = game.score >= 0 ? "Nice work! 👍" : "Phew, 🐻ly made it"
    }
    private var theme = Theme()
    
    private lazy var emojiChoices = theme.getRandomThemeIcons()

    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}

