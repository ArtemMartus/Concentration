//
//  Card.swift
//  Concentration
//
//  Created by Artem Martus on 7/26/19.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
    static func ==(l: Card, r: Card)->Bool{
        return l.identifier == r.identifier
    }
    private(set) var flipCount = 0
    var isFacedUp = false {
        willSet {
            if newValue, !isFacedUp {
                flipCount+=1
            }
        }
    }
    var isMatched = false
    private var identifier: Int
    private static var myIdentifierFactory = 1000
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    private static func getUniqueIdentifier() -> Int {
        myIdentifierFactory += 1
        return myIdentifierFactory
    }
}
