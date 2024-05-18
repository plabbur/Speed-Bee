//
//  ComplimentView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI
import AVFoundation

struct ComplimentView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel

    @State private var shouldFade = false
    @State private var yOffset: CGFloat = 0
    
    var body: some View {
        Group {
                HStack {
                    Text(dataModel.returnCompliment())
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 2)
                                .padding(-7)
                        )
                        .padding(.horizontal, 7)
                    
                    Text("+\(dataModel.returnPoints())")
                        .fontWeight(.bold)
                }
                .opacity(shouldFade ? 0 : 1)
                .offset(y: shouldFade ? -yOffset : 0)
            }
        .onAppear {
            
            if dataModel.soundsOn {
                if dataModel.returnCompliment() == "Pangram!" {
                    AudioServicesPlaySystemSound(1013)
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 0.5)) {
                    dataModel.newWord = false
                    shouldFade = true
                }
                withAnimation(.easeOut(duration: 0.3)) {
                    yOffset = 20
                }
            }
        }
    }
}



#Preview {
    ComplimentView()
        .environmentObject(SpeedBeeDataModel())
}
