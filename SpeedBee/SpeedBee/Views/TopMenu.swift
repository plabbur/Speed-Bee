//
//  TopMenu.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct TopMenu: View {
    
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
            }
            .frame(height: 10)
            .padding(.vertical, 10)
            .padding(.bottom, 10)
        }
    }
}
//
//struct Top_Menu_Previews: PreviewProvider {
//    static var previews: some View {
//        Top_Menu()
//            .environmentObject(SpeedBeeDataModel())
//    }
//}
