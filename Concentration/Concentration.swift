//
//  Concentration.swift
//  Concentration
//
//  Created by Artem Martus on 7/26/19.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation

class Concentration{
    private(set) var cards = [Card]()
    private var indexOfLastCard: Int? {
        get {
            var index: Int?
            for i in cards.indices {
                if cards[i].isFacedUp {
                    if index != nil {
                        return nil
                    } else {
                        index = i
                    }
                }
            }
            return index
        }
        set {
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matched = indexOfLastCard, matched != index {
                //check if both are same
                if cards[matched].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matched].isMatched = true
                }
                cards[index].isFacedUp = true
            } else {
                indexOfLastCard = index
            }
        }
    }
    
    init(numOfCardPairs n: Int) {
        for _ in 0 ..< n {
            let card = Card()
            cards += [card,card]
        }
        cards.shuffle()
    }
}
