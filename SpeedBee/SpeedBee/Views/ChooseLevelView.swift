//
//  ChooseLevelView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct ChooseLevelView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @State var yOffset = 900
    @State var opacityOffset: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: geometry.size.width, height: 500)
                    .position(x: (geometry.size.width / 2), y: geometry.size.height)
                    .overlay(
                        List {
                            Button(action: {
                                dataModel.timeRemaining = 600
                                dataModel.timePlayed = 600
                                dataModel.newGame()
                            } ) {
                                Text("10:00")
                            }
                            .frame(width: geometry.size.width, alignment: .center)
                            .padding(.vertical, 8)
                            
                            Button(action: {
                                dataModel.timeRemaining = 300
                                dataModel.timePlayed = 300
                                dataModel.newGame()
                            } ) {
                                Text("5:00")
                            }
                            .frame(width: geometry.size.width, alignment: .center)
                            .padding(.vertical, 8)
                            
                            Button(action: {
                                dataModel.timeRemaining = 120
                                dataModel.timePlayed = 120
                                dataModel.newGame()
                            } ) {
                                Text("2:00")
                            }
                            .frame(width: geometry.size.width, alignment: .center)
                            .padding(.vertical, 8)
                            
                            Button(action: {
                                dataModel.timeRemaining = 60
                                dataModel.timePlayed = 60
                                dataModel.newGame()
                            } ) {
                                Text("1:00")
                            }
                            .frame(width: geometry.size.width, alignment: .center)
                            .padding(.vertical, 8)
                            
                            Button(action: {
                                dataModel.timeRemaining = 30
                                dataModel.timePlayed = 30
                                dataModel.newGame()
                            } ) {
                                Text("0:30")
                            }
                            .frame(width: geometry.size.width, alignment: .center)
                            .padding(.vertical, 8)
                            
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .listRowBackground(Color.clear)
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .frame(width: geometry.size.width, height: 400, alignment: .center)
                        .position(x: (geometry.size.width / 2), y: geometry.size.height - 20)
                    )
            }
            .frame(height: geometry.size.height + 200)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .black.opacity(opacityOffset),
                        .black.opacity(opacityOffset)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .onTapGesture {
                    dataModel.onScreen = SpeedBeeDataModel.viewMode.HOME
                }
            )
            .ignoresSafeArea()
            .position(x: geometry.size.width / 2, y: CGFloat(yOffset))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        yOffset = 380
                    }
                    withAnimation(.easeIn(duration: 0.25)) {
                        opacityOffset = 0.4

                    }
                }
            }
            
        }
    }
}


#Preview {
    ChooseLevelView()
        .environmentObject(SpeedBeeDataModel())
}
