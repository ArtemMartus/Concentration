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
    
    func setScore(score:Int) {
        self.statsLabel.text = "Score: \(score)"
    }
    
    @IBOutlet private weak var statsLabel: UILabel!
    private let themes = [Theme(emojiArray: ["👻","👾","👹","🤖","🎃","👺","☠️","👽"]),
                          Theme(emojiArray: ["💋","👅","🤙🏻","👂🏻","💄","🧓🏻","👨🏻‍🎤","🙋🏻‍♂️"]),
                          Theme(emojiArray: ["🦁","🐭","🙈","🙉","🐶","🐱","🦊","🐼"]),
                          Theme(emojiArray: ["🐠","🐟","🐬","🐳","🐋","🦈","🐡","🐙"]),
                          Theme(emojiArray: ["🌞","🌝","🌚","🌕","🌏","⭐️","☄️","🌙"]),
                          Theme(emojiArray: ["🥑","🍆","🍅","🥕","🥐","🥬","🌶","🌽"]),]
    
    private var emojiArray = [String]()
    
    @IBAction private func cardTouched(_ button: UIButton) {
        let emojiIndex = buttons.firstIndex(of: button)!
        
        game.chooseCard(at: emojiIndex)
        updateFromModel()
    }
    
    @IBAction private func newGamePressed(_ sender: UIButton) {
        newGame()
    }
    
    private func newGame(){
        setScore(score: 0)
        game = Concentration(numOfCardPairs: numOfPairsOfCards)
        game.delegate = self
        emoji = [Card:String]()
        updateFromModel()
        emojiArray = themes[Int.random(in: 0..<themes.count)].emojiArray
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
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiArray.count > 0 {
            emoji[card] = emojiArray.remove(at: Int.random(in: 0 ..< emojiArray.count))
        }
        return  emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
        // Do any additional setup after loading the view.
    }
    
    
}

