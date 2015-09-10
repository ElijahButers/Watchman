//
//  InterfaceController.swift
//  Watchman WatchKit Extension
//
//  Created by Daniel Tomlinson on 10/09/2015.
//  Copyright © 2015 Rocket Apps. All rights reserved.
//

import WatchKit
import Foundation

class ContextObject {
    var input: String?
    var output: Character?
}

class InterfaceController: WKInterfaceController {
    var contextObject: ContextObject?
    var gameState: GameState!
    
    @IBOutlet var hangmanImageView: WKInterfaceImage!
    @IBOutlet var guessLabel: WKInterfaceLabel!
    
    @IBAction func resetGameButtonTapped() {
        let list = WordList(fileURL: NSBundle.mainBundle().pathForResource("words", ofType: "txt")!)
        let word = list.fetchRandomWord()
        gameState = GameState(answer: word)
        updateUI()
    }
    
    @IBAction func pickCharacterButtonTapped() {
        if gameState.frame == .Frame11 {
            WKInterfaceDevice().playHaptic(.Failure)
            
            return
        }
        
        let string = String(Array(gameState.guessedCharacters))
        
        contextObject = ContextObject()
        contextObject?.input = string
        
        pushControllerWithName("CharacterPicker", context: contextObject)
    }
    
    override func didAppear() {
        super.didAppear()
        
        if let output = self.contextObject?.output {
            if gameState.guess(output) {
                WKInterfaceDevice().playHaptic(.Success)
            }
            else {
                WKInterfaceDevice().playHaptic(.Failure)
            }
        }
        
        if let _ = self.gameState {
            updateUI()
        }
        else {
            resetGameButtonTapped()
        }
        
        contextObject = nil
    }
    
    func updateUI() {
        guessLabel.setText(gameState.displayString())
        animateWithDuration(0.2) {
            self.hangmanImageView.setImageNamed(self.gameState.frame.rawValue)
        }
    }
}
