//
//  StatsPlaqueView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct StatsPlaqueView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel

    var scoreTitle: String = "Average Word Count"
    var scoreData: String = "30"
    var scoreIcon: String = "AverageWordCountIcon"
    var scoreBest: Bool = true
    
    var body: some View {
        
        GeometryReader { geometry in
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: scoreBest ? .yellow : Color(.lightGray), radius: 5)
                .frame(width: geometry.size.width - 40, height: 100)
                .overlay(
                    VStack {
                        HStack {
                            Image(scoreIcon)
                                .padding(.leading)
                                .scaleEffect(1.2)
                            Spacer()
                            Text(scoreData)
                                .padding(.trailing, 20)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        Text(scoreTitle)
                            .fontWeight(.semibold)
                            .frame(width: geometry.size.width - 40, alignment: .leading)
                            .padding(.leading, 40)
                    }
                    
                )
                .frame(width: geometry.size.width, alignment: .center)
                .padding(.bottom, 5)

        }
    }
}

#Preview {
    StatsPlaqueView()
}
