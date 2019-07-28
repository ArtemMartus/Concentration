//
//  ViewController.swift
//  Concentration
//
//  Created by Artem Martus on 7/25/19.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var buttons: [UIButton]!
    
    private var numOfPairsOfCards: Int {
        return (1 + buttons.count) / 2
    }
    
    private lazy var game = Concentration(numOfCardPairs: numOfPairsOfCards)
    
    @IBOutlet private weak var statsLabel: UILabel!
    private var emojiArray = ["👻","👾","👹","🤖","🎃","👺","☠️","👽"]
    private(set) var flipCount = 0 {
        didSet{
            statsLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction private func cardTouched(_ button: UIButton) {
        let emojiIndex = buttons.firstIndex(of: button)!
        
        game.chooseCard(at: emojiIndex)
        updateFromModel()
        flipCount += 1
    }
    
    @IBAction private func newGamePressed(_ sender: UIButton) {
        flipCount = 0
        game = Concentration(numOfCardPairs: (1 + buttons.count) / 2)
        emoji = [Int:String]()
        updateFromModel()
    }
    
    private func updateFromModel(){
        for index in buttons.indices {
            let button = buttons[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : .orange
            }
        }
    }
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiArray.count > 0 {
            emoji[card.identifier] = emojiArray.remove(at: Int.random(in: 0 ... emojiArray.count))
        }
        return  emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

