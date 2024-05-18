//
//  PauseView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/15/24.
//

import SwiftUI

struct PauseView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .frame(width: 350, height: 480)
                
                VStack {
                    Text("Pause")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                        .padding()
                    HStack {
                        Spacer()
                        VStack {
                            Text("Timer")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                            Text(dataModel.minuteTimer())
                                .font(.system(size: 16))
                        }
                        Spacer()
                        VStack {
                            Text("Points")
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                            Text(String(dataModel.pointsReceived))
                                .font(.system(size: 16))
                        }
                        Spacer()
                    }
                    ZStack {
                        Divider()
                            .frame(width: 350)
                        HStack {
                            Text("")
                            Text("Useful Tip")
                            Text("")
                        }
                        .background(.white)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                        
                    }
                    .padding()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 298, height: 175)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color("mainYellow").opacity(0.10), Color("mainYellow").opacity(0.20)]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(20)
                        VStack {
                            Image("hintBulbYellow")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Hints")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            Text("Tap the hint button to see the first three letters of a pangram")
                                .font(.system(size: 14))
                                .foregroundColor(Color(red: 0.50, green: 0.50, blue: 0.50))
                                .frame(width: 200)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(width: 298, height: 55.0)
                            .overlay(
                                Button(action: { dataModel.timePause.toggle() }) {
                                    Text("Resume Game")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                }
                                    .padding()
                                    .foregroundColor(.white)
                                    .frame(width: 298, height: 55.0)
                                    .background(.yellow)
                                    .cornerRadius(40)
                                
                            )
                    }
                    
                }
            }
            .frame(height: geometry.size.height)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .black.opacity(0.40),
                        .black.opacity(0.40)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
        }
    }
    
}

#Preview {
    PauseView()
        .environmentObject(SpeedBeeDataModel())
}
