//
//  StatsPageView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 5/6/24.
//

import SwiftUI

struct StatsPageView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    var timeSelect: Int
    var body: some View {
       
        ScrollView(showsIndicators: false) {
            VStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 1, height: 1)
                
                VStack {
                    HStack {
                        Text("Games")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                            .padding(.top, 20)
                        Spacer()
                    }

                    StatsPlaqueView(scoreTitle: "Games Played", scoreData: dataModel.currentStat.gamesPlayed(filter: timeSelect), scoreIcon: "GamesPlayedIcon", scoreBest: false)
                        .padding(.bottom, 100)
                }
                .padding(.bottom)
                
                VStack {
                    HStack {
                        Text("Score")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        Spacer()
                    }
                    StatsPlaqueView(scoreTitle: "Highest Score", scoreData: dataModel.currentStat.highestScore(filter: timeSelect), scoreIcon: "HighestScoreIcon", scoreBest: true)
                        .padding(.bottom, 100)
                    
                    StatsPlaqueView(scoreTitle: "Average Score", scoreData: dataModel.currentStat.averageScore(filter: timeSelect), scoreIcon: "AverageScoreIcon", scoreBest: false)
                        .padding(.bottom, 100)
                    
                }
                .padding(.bottom)
                
                VStack {
                    HStack {
                        Text("Words")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .padding(.leading, 20)
                            .padding(.top, 10)
                        Spacer()
                    }
                    StatsPlaqueView(scoreTitle: "Highest Word Count", scoreData: dataModel.currentStat.highestWordCount(filter: timeSelect), scoreIcon: "HighestWordCountIcon", scoreBest: true)
                        .padding(.bottom, 100)
                    
                    StatsPlaqueView(scoreTitle: "Average Word Count", scoreData: dataModel.currentStat.averageWordCount(filter: timeSelect), scoreIcon: "AverageWordCountIcon", scoreBest: false)
                        .padding(.bottom, 100)
                }
                
                Rectangle()
                    .frame(height: 100)
                    .foregroundColor(.clear)
            }
                        
        }
        .background(Color(red: 0.939, green: 0.939, blue: 0.939))
    }
}

#Preview {
    StatsPageView(timeSelect: 30)
        .environmentObject(SpeedBeeDataModel())
}
