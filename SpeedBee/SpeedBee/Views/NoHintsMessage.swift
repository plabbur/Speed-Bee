//
//  NoHintsMessage.swift
//  SpeedBee
//
//  Created by Cole Abrams on 6/24/24.
//

import SwiftUI

struct NoHintsMessage: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @State private var opacityVal: Double = 100

    var body: some View {
        
        Text("All pangrams solved!")
            .background(RoundedRectangle(cornerRadius: 5).fill(.gray).padding())
            .foregroundColor(.black)
            .font(.system(size: 17))
            .fontWeight(.bold)
            .opacity(opacityVal)
            .transition(.opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation(.easeOut(duration: 3)) {
                        opacityVal = 0
                        dataModel.showNoHintsMessage = false
                    }
                }
            }
    }
}

#Preview {
    NoHintsMessage()
}
