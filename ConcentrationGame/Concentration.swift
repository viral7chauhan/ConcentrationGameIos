//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Viral Chauhan on 04/01/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard : Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        } set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
    }
    
    func chooseCard (at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index)) : Chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)) : Put atleast one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let newCard = Card()
            cards += [newCard, newCard]
            cards.shuffled()
        }
        print("Cards \(cards)")
        
    }
    
    func resetGame () {
        let length = cards.count/2
        cards.removeAll()
        for _ in 1...length {
            let newCard = Card()
            cards += [newCard, newCard]
            cards.shuffled()
        }
    }
    
}

extension Array {
    mutating func shuffled () {
        var length = self.count
        for _ in self {
            if length-1 != length.arc4random {
                self.swapAt(length-1, length.arc4random)
            }
            
            length -= 1
        }
    }
}
