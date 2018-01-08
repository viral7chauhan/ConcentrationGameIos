//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Viral Chauhan on 04/01/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class ViewController : UIViewController {
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipTitleLabel: UILabel!
    
    lazy private var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }
    
    private let allEmojis = ["⛄️", "🐙", "🙀", "👹", "😈", "💩", "👻", "🎃", "🤖", "👁", "👽"]
    private var emojis = [String]()
    
    
    private(set) var flipCount = 0 {
        didSet {
            flipTitleLabel.text = "Flips : \(flipCount)"
        }
    }
    
    private let openCardColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private let closeCardColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    private let matchCardColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    
    override func viewDidLoad() {
        emojis = allEmojis
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction private func touchStartAgain(_ sender: UIButton) {
        game.resetGame()
        emojisPair.removeAll()
        emojis = allEmojis
        updateViewFromModel ()
        flipCount = 0
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card is not found")
        }
    }
    
    private func updateViewFromModel () {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmojis(for: card), for: UIControlState.normal)
                button.backgroundColor = openCardColor
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? matchCardColor : closeCardColor
            }
        }
    }
    
    private var emojisPair = [Card:String]()
    
    private func getEmojis (for card: Card) -> String {
        if emojisPair[card] == nil, emojis.count > 0 {
            emojisPair[card] = emojis.remove(at: emojis.count.arc4random)
        }
        
        return emojisPair[card] ?? "?"
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

