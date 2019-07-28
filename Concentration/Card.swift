//
//  Card.swift
//  Concentration
//
//  Created by Artem Martus on 7/26/19.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation

struct Card{
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    private static var myIdentifierFactory = 1000
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    private static func getUniqueIdentifier() -> Int {
        myIdentifierFactory += 1
        return myIdentifierFactory
    }
}
