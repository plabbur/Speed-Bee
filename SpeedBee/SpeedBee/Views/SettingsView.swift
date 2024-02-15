//
//  SettingsView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {

                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                            .padding(.horizontal)
                            .frame(height: 200)
                            .overlay(
                                VStack {
                                    // Sounds On
                                    Toggle(isOn: $dataModel.soundsOn) {
                                        Text("Sounds")
                                    }
                                    .padding(.vertical, 2)
                                    
                                    // Vibration On
                                    Toggle(isOn: $dataModel.vibrationOn) {
                                        Text("Vibration")
                                    }
                                    .padding(.vertical, 2)
                                    
                                    // Hints On
                                    Toggle(isOn: $dataModel.hintsOn) {
                                        Text("Hints")
                                    }
                                    .padding(.vertical, 2)
                                    
                                    // Hints On
                                    Toggle(isOn: $dataModel.limitMistakesOn) {
                                        Text("Limit Mistakes")
                                    }
                                    .padding(.vertical, 2)
                                }
                                .padding(.horizontal, 40)
//                                .zIndex(1)
//                                .listStyle(PlainListStyle())
//                                .padding(.top, 20)
                            )
                    }
                    .padding(.bottom, 10)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                            .padding(.horizontal)
                            .frame(height: 55)
                            .overlay(
                                Button("Reset Statistics") {
                                    dataModel.currentStat.resetStats()
                                }
                                .foregroundColor(.red)
                                .padding(.vertical, 2)
                                .frame(width: geometry.size.width - 80, alignment: .leading)
                            )
                    }
                    
                }
                .tint(.yellow)
                .padding(.top)
            }
            .navigationTitle("Settings")
        }
        .background(Color(red: 0.933, green: 0.933, blue: 0.933))
    }
}

#Preview {
    SettingsView()
        .environmentObject(SpeedBeeDataModel())
}
