//
//  ViewController.swift
//  Concentration
//
//  Created by Anna Garcia on 5/15/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func touchCard(_ sender: UIButton) {
        if cardButtons.index(of: sender) != nil{
           flipCard(with: "👻", on: sender)
        }else {
            print("card is not in cardButton array")
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var flipCount = 0 {didSet { flipCountLabel.text = "Flip Count: \(flipCount)" }}
    
    func flipCard(with emoji:String, on button: UIButton){
        flipCount += 1
        if button.currentTitle != emoji {
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.setTitle(emoji, for: UIControlState.normal)
        }else {
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            button.setTitle("", for: UIControlState.normal)
        }
        
    }
    
   
    
}

