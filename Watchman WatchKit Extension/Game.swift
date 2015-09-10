//
//  Game.swift
//  Watchman
//
//  Created by Daniel Tomlinson on 10/09/2015.
//  Copyright © 2015 Rocket Apps. All rights reserved.
//

import Foundation

struct GameState {
    let answer: String
    var guessedCharacters: Set<Character> = Set()
    
    init(answer: String) {
        self.answer = answer
    }
    
    mutating func guess(character: Character) -> Bool {
        guessedCharacters.insert(character)
        
        return answer.characters.contains(character)
    }
}