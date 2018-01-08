//
//  Card.swift
//  ConcentrationGame
//
//  Created by Viral Chauhan on 04/01/18.
//  Copyright © 2018 Viral Chauhan. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    private var identifier: Int
    var isFaceUp = false
    var isMatched = false
 
    static private var identityFactory = 0
    
    static private func getUniqueIdentifier () -> Int {
        identityFactory += 1
        return identityFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    mutating func resetCard () {
        self.isFaceUp = false
        self.isMatched = false
    }
}
