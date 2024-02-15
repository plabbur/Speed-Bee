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
    var exampleScoreList: [[Int]] = [[0, 10], [1, 20], [2, 30], [3, 40]]
    var wordCountList: [[Int]] = [[Int]]()
    var statsFilter: Int = 30
    
    func filterList(list: [[Int]]) -> [Int] {
        var filteredList: [Int] = []
        
        for item in 0..<list.count {
            if list[item][1] == statsFilter {
                filteredList.append(list[item][0])
            }
        }
        
        return filteredList
    }
    
    
    var highestScore: Int {
        filterList(list: scoreList).max() ?? 0
    }
    
    var averageScore: Int {
        if filterList(list: scoreList).isEmpty {
            0
        } else {
            filterList(list: scoreList).reduce(0, +) / filterList(list: scoreList).count
        }
    }
    
    var highestWordCount: Int {
        filterList(list: wordCountList).max() ?? 0
    }
    
    var averageWordCount: Int {
        if filterList(list: wordCountList).isEmpty {
            0
        } else {
            filterList(list: wordCountList).reduce(0, +) / wordCountList.count
        }
    }
    
    var gamesPlayed: Int {
        filterList(list: scoreList).count
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
    }
    
    mutating func resetStats() {
        scoreList = [[Int]]()
        wordCountList = [[Int]]()
    }
}
