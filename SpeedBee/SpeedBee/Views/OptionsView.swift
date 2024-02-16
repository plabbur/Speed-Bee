//
//  OptionsView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct OptionsView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var doneButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            dataModel.onScreen = SpeedBeeDataModel.viewMode.HOME
        }) {
            Text("Done")
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
        }
    }
    
    var body: some View {
        
        GeometryReader { geometry in

            VStack {
                
                NavigationView {
                    
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.white)
                                .padding(.horizontal)
                                .overlay(
                                    VStack {
                                        NavigationLink(destination: SettingsView().tint(.yellow)) {
                                            Image("SettingsNavIcon")
                                                .padding(.trailing, 5)
                                            Text("Settings")
                                            Spacer()
                                            Image("navArrowRight")
                                                .padding(.trailing, 15)
                                        }
                                        .padding(.bottom, 2)
                                        .padding(.leading)
                                        .frame(width: geometry.size.width - 40, alignment: .leading)
                                        
                                        NavigationLink(destination: HowToPlayView()) {
                                            Image("RulesNavIcon")
                                                .padding(.trailing, 5)
                                            Text("How to play")
                                            Spacer()
                                            Image("navArrowRight")
                                                .padding(.trailing, 15)
                                        }
                                        .padding(.bottom, 2)
                                        .padding(.leading)
                                        .frame(width: geometry.size.width - 40, alignment: .leading)
                                    }
                                )
                                .frame(height: 120)
                        }
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                        
                    }
                    .position(x: geometry.size.width / 2, y: 100)
                    .navigationTitle("Options")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(trailing: doneButton)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                    .background(Color(red: 0.933, green: 0.933, blue: 0.933))
                    
                }
                .navigationBarBackButtonHidden(true)
                .accentColor(.yellow)
                
            }
            
        }
    }
}

#Preview {
    OptionsView()
        .environmentObject(SpeedBeeDataModel())
}
