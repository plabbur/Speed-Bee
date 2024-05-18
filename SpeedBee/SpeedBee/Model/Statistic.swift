//
//  Statistic.swift
//  SpeedBee
//
//  Created by Cole Abrams on 1/5/24.
//

import Foundation
import SwiftUI

struct Statistic: Codable {
    
    var scoreList: [[Int]] = [[Int]]()
    var exampleScoreList: [[Int]] = [[2, 30], [8, 30], [0, 60], [2, 300], [3, 600]]
    var wordCountList: [[Int]] = [[Int]]()
    
    func filterList(list: [[Int]], filter: Int) -> [Int] {
        var filteredList: [Int] = [Int]()
        
        for item in 0..<list.count {
            if list[item][1] == filter {
                filteredList.append(list[item][0])
            }
        }
        
        return filteredList
    }
    
    
    func highestScore(filter: Int) -> Int {
        filterList(list: scoreList, filter: filter).max() ?? 0
    }
    
    func averageScore(filter: Int) -> Int {
        if filterList(list: scoreList, filter: filter).isEmpty {
            0
        } else {
            filterList(list: scoreList, filter: filter).reduce(0, +) / filterList(list: scoreList, filter: filter).count
        }
    }
    
    func highestWordCount(filter: Int) -> Int {
        filterList(list: wordCountList, filter: filter).max() ?? 0
    }
    
    func averageWordCount(filter: Int) -> Int {
        if filterList(list: wordCountList, filter: filter).isEmpty {
            0
        } else {
            filterList(list: wordCountList, filter: filter).reduce(0, +) / wordCountList.count
        }
    }
    
    func gamesPlayed(filter: Int) -> Int {
        filterList(list: scoreList, filter: filter).count
    }
    
    func saveStat() {
        
        if let encoded = try? JSONEncoder().encode(self) {
            
            UserDefaults.standard.set(encoded, forKey: "Stat")
        }
    }
    
    static func loadStat() -> Statistic {
        if let savedStat = UserDefaults.standard.object(forKey: "Stat") as? Data {
            if let currentStat = try? JSONDecoder().decode(Statistic.self, from: savedStat) {
                return currentStat
            } else {
                return Statistic()
            }
        } else {
            return Statistic()
        }
    }
    
    mutating func update(pointsReceived: Int, wordCount: Int, timePlayed: Int) {
        scoreList.append([pointsReceived, timePlayed])
        wordCountList.append([wordCount, timePlayed])
        saveStat()
    }
    
    mutating func resetStats() {
        scoreList.removeAll()
        wordCountList.removeAll()
        saveStat()
    }
}
