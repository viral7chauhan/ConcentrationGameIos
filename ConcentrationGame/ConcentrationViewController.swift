//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Viral Chauhan on 04/01/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import UIKit

class ConcentrationViewController : UIViewController {
    
    // MARK: Outlets
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipTitleLabel: UILabel! {
        didSet {
            updateFlipLabel()
        }
    }
    
    // MARK: Properties
    lazy private var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { return (cardButtons.count+1)/2 }

    private let openCardColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    private let closeCardColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    private let matchCardColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    
    private var emojisChoices = "⛄️🐙🙀👹😈💩👻🎃🤖👁👽"
    private var emojisChoicesCopy: String?
    
    var flipCount = 0 { didSet { updateFlipLabel() } }
    
    private var emojisPair = [Card:String]()
    
    var theme: String? {
        didSet {
            emojisChoices = theme ?? ""
            emojisChoicesCopy = emojisChoices
            emojisPair = [:]
            updateViewFromModel()
        }
    }
    
    // MARK: ViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()
        emojisChoicesCopy = emojisChoices
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: IBAction methods
    @IBAction private func touchStartAgain(_ sender: UIButton) {
        if let emojisCopy = emojisChoicesCopy {
            emojisChoices = emojisCopy
        }
        game.resetGame()
        emojisPair = [:]
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
    
    
    
    // MARK: Methods
    fileprivate func updateFlipLabel() {
        let attributeKey: [NSAttributedStringKey:Any] = [
            NSAttributedStringKey.strokeWidth : 5,
            NSAttributedStringKey.strokeColor : closeCardColor
        ]
        let attributeString = NSAttributedString(string: "Flips : \(flipCount)", attributes: attributeKey)
        flipTitleLabel.attributedText = attributeString
    }
    
    
    private func updateViewFromModel () {
        if cardButtons != nil {
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
    }
    
    
    private func getEmojis (for card: Card) -> String {
        if emojisPair[card] == nil, emojisChoices.count > 0 {
            let randomStringIndex = emojisChoices.index(emojisChoices.startIndex, offsetBy: emojisChoices.count.arc4random)
            emojisPair[card] = String(emojisChoices.remove(at: randomStringIndex))
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

