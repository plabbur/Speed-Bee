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
    @State private var color = Color.gray
    @State private var rectWidth: CGFloat = 100
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                ZStack {
                    
                    if !dataModel.gameTimeUnlimited {
                        VStack {
                            if !dataModel.gameTimeUnlimited {
                                Text("Timer")
                                    .padding(.horizontal, dataModel.limitMistakesOn ? 0 : 15)
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                    .onReceive(timer) { _ in
                                        if (dataModel.timeRemaining > 0 && !dataModel.timePause) {
                                            dataModel.timeRemaining -= 1
                                        } else if dataModel.timeRemaining == 0 {
                                            dataModel.gameOver = true
                                            dataModel.gameEnd()
                                        }
                                    }
                                
                                Text(dataModel.minuteTimer())
                                    .padding(.horizontal, dataModel.limitMistakesOn ? 0 : 15)
                                    .fontWeight(.semibold)
                                    .foregroundColor(dataModel.timeRemaining < 6 ? Color.red : color)
                                    .onChange(of: dataModel.currentWord) { newValue in
                                        do {
                                            if !dataModel.errorFound {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    color = Color.yellow
                                                }
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                    withAnimation(.easeInOut(duration: 0.5)) {
                                                        color = Color.gray
                                                    }
                                                }
                                            }
                                    }
                                }
                                
                            }
                        }
                        .frame(width: geometry.size.width - 50, alignment: .leading)
                    }
                        
                    
                    VStack {
                        Text("Points")
                            .font(.system(size: 12))
                        
                        Text(String(dataModel.pointsReceived))
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.gray)
                    .frame(width: dataModel.gameTimeUnlimited ? geometry.size.width - 50 : geometry.size.width - 170, alignment: .leading)

                    
                    if dataModel.limitMistakesOn {
                        VStack {
                            Text("Mistakes")
                                .font(.system(size: 12))
                            
                            Text("\(dataModel.mistakeCounter)/3")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.gray)
                        .frame(width: dataModel.gameTimeUnlimited ? geometry.size.width - 265 : geometry.size.width - 320, alignment: dataModel.gameTimeUnlimited ? .trailing : .leading)
                    }
                    
                    if !dataModel.gameTimeUnlimited {
                        Button(action: { dataModel.timePause = true }) {
                            if (dataModel.timePause) {
                                Image("playButton")
                            } else {
                                Image("pauseButton")
                            }
                        }
                        .frame(width: geometry.size.width - 250, alignment: .trailing)
                    }
                    
                    if dataModel.hintsOn {
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
                        .frame(width: geometry.size.width - 40, alignment: .trailing)
                    }
                }
                
                Divider()
            }
        }
    }
}

#Preview {
    TimerHintsView()
        .environmentObject(SpeedBeeDataModel())
}
