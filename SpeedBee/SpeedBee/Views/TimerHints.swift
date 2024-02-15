//
//  TimerHints.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI


struct TimerHintsView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                HStack {
                    VStack {
                        Text("Timer")
                            .padding(.horizontal, dataModel.limitMistakesOn ? 0 : 15)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .onReceive(timer) { _ in
                                if (dataModel.timeRemaining > 0 && !dataModel.timePause) {
                                    dataModel.timeRemaining -= 1
                                } else if dataModel.timeRemaining == 0 {
                                    dataModel.gameOver = true
                                }
                            }
                        
                        Text(dataModel.minuteTimer())
                            .padding(.horizontal, dataModel.limitMistakesOn ? 0 : 15)
                            .fontWeight(.semibold)
                            .foregroundColor(dataModel.timeRemaining > 5 ? Color.gray : Color.red)
                    }
                    .frame(width: 90)
                    
                    VStack {
                        Text("Points")
                            .padding(.horizontal, dataModel.limitMistakesOn ? 0 : 15)
                            .font(.system(size: 12))
                        
                        Text(String(dataModel.pointsReceived))
                            .padding(.horizontal, dataModel.limitMistakesOn ? 0 : 15)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    .padding(.trailing, dataModel.limitMistakesOn ? 0 : 68)
                    
                    if dataModel.limitMistakesOn {
                        VStack {
                            Text("Mistakes")
                                .padding(.horizontal)
                                .font(.system(size: 12))
                            
                            Text("\(dataModel.mistakeCounter)/3")
                                .padding(.horizontal)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.gray)
                        .padding(.trailing, 5)
                    }
                    
                    Button(action: { dataModel.timePause = true }) {
                        if (dataModel.timePause) {
                            Image("playButton")
                        } else {
                            Image("pauseButton")
                        }
                    }
                    
                    Button(action: { dataModel.showHint = true }) {
                        Text("Hint")
                        Image("hintBulbYellow")
                    }
                    .padding()
                    .frame(width: 95.0, height: 40.0)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
                    )
                }
                
                Divider()
                
//                ProgressBarView(timeLeft: $dataModel.timeRemaining, timeTotal: $dataModel.timePlayed)
                
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: geometry.size.width * 2 * CGFloat(dataModel.timeRemaining / dataModel.timePlayed), height: 15)
//                    .foregroundColor(dataModel.timeRemaining > 10 ? .yellow : .red)
//                    .animation(.linear(duration: CGFloat(dataModel.timePlayed)))
//                    .position(x: 0)
            }
        }
    }
}

struct TimerHintsView_Previews: PreviewProvider {
    static var previews: some View {
        return TimerHintsView()
            .environmentObject(SpeedBeeDataModel())
    }
}
