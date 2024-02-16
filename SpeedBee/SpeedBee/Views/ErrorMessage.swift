//
//  ErrorMessage.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/15/24.
//

import SwiftUI


import SwiftUI
import AVFoundation

struct ErrorMessage: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    var errorMessage: String
    @State private var opacityVal: Double = 100
    
    
    var body: some View {
        VStack {
            ZStack {
                Text(errorMessage)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.black).padding(-7))
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .opacity(opacityVal)
                    .transition(.opacity)
                    .zIndex(1)
                
                Text(errorMessage)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.white).padding(-7))
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .opacity(opacityVal)
                    .transition(.opacity)
                    .zIndex(0)
            }
            
        }
        .onAppear {
            
            if dataModel.soundsOn {
                AudioServicesPlaySystemSound(1111)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeOut(duration: 0.5)) {
                    dataModel.newWord = false
                    opacityVal = 0
                    
                }
            }
        }
    }
}
