//
//  GameOverConfirmView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 3/22/24.
//

import SwiftUI

struct GameOverConfirmView: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .frame(width: 350, height: 150)
                
                VStack {
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 298, height: 55.0)
                        .overlay(
                            Button(action: { dataModel.gameOverConfirm = false }) {
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
                    
                    
                    Button(action: { 
                        dataModel.gameEnd()
                        dataModel.gameOverConfirm = false
                    }) {
                            Text("End Game")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 10)
                        .foregroundColor(.red)
                        .background(.white)
                        .cornerRadius(40)
                }
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
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
    GameOverConfirmView()
        .environmentObject(SpeedBeeDataModel())
}
