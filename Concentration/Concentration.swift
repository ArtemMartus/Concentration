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
    weak var delegate: ViewController?
    private(set) var score = 0 {
        didSet{
            delegate?.setScore(score:score)
        }
    }
    private var indexOfLastCard: Int? {
        get {
            return cards.indices.filter{ return cards[$0].isFacedUp }.oneAndOnly()
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
                if cards[matched] == cards[index] {
                    cards[index].isMatched = true
                    cards[matched].isMatched = true
                    score += 2
                } else if cards[index].flipCount > 0 {
                    score -= 1
                }
                
                cards[index].isFacedUp = true
                
            } else {
                if cards[index].flipCount > 0 {
                    score -= 1
                }
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

extension Collection{
    func oneAndOnly() -> Element? {
        return count == 1 ? first : nil
    }
}
