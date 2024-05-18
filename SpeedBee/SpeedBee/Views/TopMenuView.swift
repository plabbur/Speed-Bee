//
//  TopMenuView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct TopMenuView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Button(action: { dataModel.onScreen = SpeedBeeDataModel.viewMode.HOME }) {
                    Image("backArrow")
                }
                .frame(width: geometry.size.width - 40, alignment: .leading)
                
                Text("Speed Bee")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width, alignment: .center)
                
                Button(action: { dataModel.gameOverConfirm = true }) {
                    Text("Stop")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .frame(width: geometry.size.width - 50, alignment: .trailing)
            }
            .frame(height: 10)
            .padding(.vertical, 10)
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    TopMenuView()
        .environmentObject(SpeedBeeDataModel())
}

