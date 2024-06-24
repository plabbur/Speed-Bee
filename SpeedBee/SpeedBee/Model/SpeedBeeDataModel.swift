//
//  SpeedBeeDataModel.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import Foundation
import SwiftUI

class SpeedBeeDataModel: ObservableObject {
    @AppStorage("SoundsOn") var soundsOn: Bool = false
    @AppStorage("VibrationOn") var vibrationOn: Bool = false
    @AppStorage("HintsOn") var hintsOn: Bool = false
    @AppStorage("LimitMistakes") var limitMistakesOn: Bool = true
    
    @Published var timePause = false
    @Published var timePlayed = 0
    @Published var timeRemaining = 0
    @Published var gameOver = true
    @Published var gameTimeUnlimited = false
    @Published var gameOverConfirm = false
    
    @Published var statTimeSelected = Double()
    
    @Published var newWord = false
    @Published var wordsFound = [String]()
    
    @Published var showHint = false
    @Published var onScreen: viewMode = viewMode.HOME
    @Published var showLevels = false
    
    var lettersChosen: [String] = ["A", "B", "C", "D", "E", "F", "G"]
    var letterCenter: String = "A"
    var lettersOther: [String] = ["B", "C", "D", "E", "F", "G"]
    var pointsReceived = 0
    var errorFound = Bool()
    var currentStat: Statistic
    var chosenIndex: Int = Int()
    var chosenLetters = String()
    var pangramAsList = [String]()
    var mistakeCounter = 0
    var currentWord: String = ""
    var currentHint: String = ""
    var showNoHintsMessage = false
    
    var hintsUsedInGame: Int = 0
    
    enum viewMode {
        case GAME
        case HOME
        case STATISTICS
        case ENDGAME
        case OPTIONS
    }
    
    var playedLetters: [String] = []
    var allLetters: [String] = [String]()
    var allPangrams: [[String]] = [[String]]()
   
    init() {
        currentStat = Statistic.loadStat()
        readAllLetters()
        readAllPangrams()
        print(allLetters)
        print(allPangrams)
    }
    
    func readAllLetters() {
        if let path = Bundle.main.path(forResource: "all_letters", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)
                allLetters = lines
            } catch {
                print(error)
            }
        }
    }
    
    func readAllPangrams() {
        if let path = Bundle.main.path(forResource: "all_pangrams", ofType: "txt") {
            do {
                var listPangrams = [[String]]()
                print("reading pangrams now")
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let lines = data.components(separatedBy: .newlines)
                for item in lines {
                    if item.contains(",") {
                        print("Item contains comma")
                        let pangramLineAsList = item.components(separatedBy: ", ")
                        listPangrams.append(pangramLineAsList)
                    } else {
                        var itemAsList = [String]()
                        itemAsList.append(item)
                        listPangrams.append(itemAsList)
                    }
                    
                    allPangrams = listPangrams
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getWord() -> [String] {
        if allLetters.isEmpty {
            allLetters = playedLetters
        }
        
        chosenIndex = Int.random(in: 0...(allLetters.count - 1))
        chosenLetters = allLetters[chosenIndex]
        playedLetters.append(chosenLetters)
        allLetters.remove(at: chosenIndex)
        
        pangramAsList = []
        for char in chosenLetters {
            pangramAsList.append(String(char))
        }
        
        return pangramAsList
    }
    
    func newGame() {        
        if timeRemaining > 98999 {
            gameTimeUnlimited = true
        }
        
        lettersChosen = getWord()
        
        letterCenter = lettersChosen[0]
        lettersOther = [lettersChosen[1], lettersChosen[2], lettersChosen[3], lettersChosen[4], lettersChosen[5], lettersChosen[6]]
        lettersOther.shuffle()
        wordsFound = [String]()
        currentWord = ""
        pointsReceived = 0
        mistakeCounter = 0
        
        gameOver = false
        showHint = false
        showLevels = false
        timePause = false
        
        onScreen = viewMode.GAME
    }
    
    func getHint() {
        
        let gamePangrams: [String] = allPangrams[chosenIndex]
        
        var allPangramsFound = true
        for pangram in gamePangrams {
            if !wordsFound.contains(pangram) {
                allPangramsFound = false
            }
        }
        
        if allPangramsFound {
            showNoHintsMessage = true
            currentHint = ""
        } else {
            let hintPangram: String = gamePangrams[hintsUsedInGame % gamePangrams.count]
            
            pangramAsList = []
            for char in hintPangram {
                pangramAsList.append(String(char))
            }
            
            if hintsUsedInGame < gamePangrams.count {
                hintsUsedInGame += 1
            }
            
            currentHint = "\(pangramAsList[0])\(pangramAsList[1])\(pangramAsList[2])..."
        }
    }
    
    func enterWord(word: String) {
        newWord = true
        showHint = false
        
        currentWord = word
        
        if !isError() {
            errorFound = false
            pointsReceived += returnPoints()
            timeRemaining += returnPoints()
            wordsFound.append(currentWord)
        } else {
            mistakeCounter += 1
            errorFound = true
        }
        
        if limitMistakesOn {
            if mistakeCounter == 3 {
                gameEnd()
            }
        }
    }
    
    func shuffleLetters() {
        lettersOther.shuffle()
    }
    
    func addToCurrentWord(_ letter: String) {
        currentWord += letter
    }
    
    func minuteTimer() -> String {
        let seconds = timeRemaining % 60
        let minutes = timeRemaining / 60
        
        if seconds >= 10 {
            return "\(minutes):\(seconds)"
        } else {
            return "\(minutes):0\(seconds)"
        }
    }
    
    func gameEnd() {
        timePause = true
        currentStat.update(pointsReceived: pointsReceived, wordCount: wordsFound.count, timePlayed: timePlayed)
        gameOver = true
    }
    
    func isPangram(word: String) -> Bool {
        return word.contains(lettersChosen[0]) && word.contains(lettersChosen[1]) && word.contains(lettersChosen[2]) && word.contains(lettersChosen[3]) && word.contains(lettersChosen[4]) && word.contains(lettersChosen[5]) && word.contains(lettersChosen[6])
    }
    
    func returnPoints() -> Int {
        if isPangram(word: currentWord) {
            return currentWord.count + 7
        } else if currentWord.count == 4 {
            return 1
        } else {
            return currentWord.count
        }
    }
    
    func returnCompliment() -> String {
        if isPangram(word: currentWord) {
            return "Pangram!"
        } else if currentWord.count == 4 {
            return "Nice!"
        } else if currentWord.count < 7 {
            return "Great!"
        } else {
            return "Excellent!"
        }
    }
    
    // ERROR MESSAGES
    
    func checkExcess() -> Bool {
        let enteredList = Array(currentWord)
        var invalid = false
        for item in enteredList {
            if !(lettersOther + [letterCenter]).contains(String(item)) {
                invalid = true
                break
            }
        }
        return invalid
    }
    
    func checkExists() -> Bool {
            let textChecker = UITextChecker()
            let range = NSRange(location: 0, length: currentWord.utf16.count)
            
            let misspelledRange = textChecker.rangeOfMisspelledWord(
                in: currentWord.lowercased(),
                range: range,
                startingAt: 0,
                wrap: false,
                language: "en"
            )
            
            return misspelledRange.location == NSNotFound
        }
    
    func getErrorMessage() -> String {
        
        if currentWord.count > 20 {
            return "Too long"
        } else if wordsFound.contains(currentWord) {
            return "Already found"
        } else if currentWord.count < 4 {
            return "Too short"
        } else if !(currentWord.contains(letterCenter)) {
            return "Missing middle letter"
        } else if checkExcess() {
            return "Includes excess letters"
        } else if !checkExists() || currentWord == "\(letterCenter)\(letterCenter)\(letterCenter)\(letterCenter)" {
            return "Not in word list"
        } else {
            return "None"
        }
    }
    
    func isError() -> Bool {
        return getErrorMessage() != "None"
    }
    
}
