//
//  SettingsView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @State var confirmReset = false
    
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
                                    Toggle(isOn: $dataModel.soundsOn) {
                                        Text("Sounds")
                                    }
                                    .padding(.vertical, 2)
                                    
                                    Toggle(isOn: $dataModel.vibrationOn) {
                                        Text("Vibration")
                                    }
                                    .padding(.vertical, 2)
                                    
                                    Toggle(isOn: $dataModel.hintsOn) {
                                        Text("Hints")
                                    }
                                    .padding(.vertical, 2)
                                    
                                    Toggle(isOn: $dataModel.limitMistakesOn) {
                                        Text("Limit Mistakes")
                                    }
                                    .padding(.vertical, 2)
                                }
                                .padding(.horizontal, 40)
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
                                    confirmReset = true
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
            
            ZStack {
                if (confirmReset == true) {
                    VStack {
                        Button(action: {                                     dataModel.currentStat.resetStats(); confirmReset = false;
                            }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
                                    
                                Text("Reset Statistics")
                                    .foregroundColor(.red)
                            }
                            .frame(width: geometry.size.width - 20, height: 60)
                        }
                        
                        Button(action: { confirmReset = false }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.white)
                                
                                Text("Cancel")
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                            }
                            .frame(width: geometry.size.width - 20, height: 60)
                        }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height - 85)
                    .font(.system(size: 20))
                }
            }
            .background(Color(.black.opacity(0.25)))
            
        }
        
        .background(Color(red: 0.933, green: 0.933, blue: 0.933))
    }
}

#Preview {
    SettingsView()
        .environmentObject(SpeedBeeDataModel())
}
