//
//  StatsView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    var navTitle: Bool = false
    @State var timeSelected = 600
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                if !navTitle {
                    Text("Statistics")
                        .fontWeight(.semibold)
                        .font(.system(size: 17))
                }
                
                Divider()
                ScrollView(.horizontal) {
                    HStack {
                        Button(action: {
                            dataModel.currentStat.statsFilter = 600
                            timeSelected = 600
                        }) {
                            Text("10:00")
                        }
                        .padding(.horizontal)
                        .foregroundColor(timeSelected == 600 ? .yellow : .gray)
                        
                        Button(action: {
                            dataModel.currentStat.statsFilter = 300
                            timeSelected = 300
                        }) {
                            Text("5:00")
                        }
                        .padding(.horizontal)
                        .foregroundColor(timeSelected == 300 ? .yellow : .gray)
                        
                        Button(action: {
                            dataModel.currentStat.statsFilter = 120
                            timeSelected = 120
                        }) {
                            Text("2:00")
                        }
                        .padding(.horizontal)
                        .foregroundColor(timeSelected == 120 ? .yellow : .gray)
                        
                        Button(action: {
                            dataModel.currentStat.statsFilter = 60
                            timeSelected = 60
                        }) {
                            Text("1:00")
                        }
                        .padding(.horizontal)
                        .foregroundColor(timeSelected == 60 ? .yellow : .gray)
                        
                        Button(action: {
                            dataModel.currentStat.statsFilter = 30
                            timeSelected = 30
                        }) {
                            Text("0:30")
                        }
                        .padding(.horizontal)
                        .foregroundColor(timeSelected == 30 ? .yellow : .gray)
                    }
                    .fontWeight(.bold)
                }
                .frame(height: 30)
                .onAppear {
                    dataModel.currentStat.statsFilter = dataModel.timePlayed
                    timeSelected = dataModel.timePlayed
                }
                
                ScrollView {
                    
                    VStack {
                        
                        HStack {
                            Text("Games")
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .padding(.leading, 20)
                                .padding(.top, 30)
                            Spacer()
                        }
                        
                        StatsPlaqueView(scoreTitle: "Games Played", scoreData: String(dataModel.currentStat.gamesPlayed), scoreIcon: "GamesPlayedIcon", scoreBest: false)
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
                        StatsPlaqueView(scoreTitle: "Highest Score", scoreData: String(dataModel.currentStat.highestScore), scoreIcon: "HighestScoreIcon", scoreBest: true)
                            .padding(.bottom, 100)
                        
                        StatsPlaqueView(scoreTitle: "Average Score", scoreData: String(dataModel.currentStat.averageScore), scoreIcon: "AverageScoreIcon", scoreBest: false)
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
                        StatsPlaqueView(scoreTitle: "Highest Word Count", scoreData: String(dataModel.currentStat.highestWordCount), scoreIcon: "HighestWordCountIcon", scoreBest: true)
                            .padding(.bottom, 100)
                        
                        StatsPlaqueView(scoreTitle: "Average Word Count", scoreData: String(dataModel.currentStat.averageWordCount), scoreIcon: "AverageWordCountIcon", scoreBest: false)
                            .padding(.bottom, 100)
                    }
                    
                }
                .background(Color(red: 0.932, green: 0.932, blue: 0.932))

            }
        }
        
    }
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(SpeedBeeDataModel())
    }
}
