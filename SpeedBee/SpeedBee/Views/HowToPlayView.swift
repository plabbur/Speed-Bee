//
//  HowToPlayView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        GeometryReader { geometry in
            Divider()
            
            VStack {
                Text("Rules")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.bottom, 2)
                    .padding(.top, 20)
                    .frame(width: geometry.size.width, alignment: .leading)
                HStack {
                    
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("Words must contain at least 4 letters.")
                        
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)
                    

                HStack {
                    
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("Words must include the center letter.")
                        
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)
                    
            
                HStack {
                    
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("Letters can be used more than once.")
                        
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)
                
                Text("Scoring")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                    .padding(.leading)
                    .padding(.bottom, 2)
                    .padding(.top, 20)
                    .frame(width: geometry.size.width, alignment: .leading)
                
                
                HStack {
                    
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("4-letter words are worth 1 point each.")
                        
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)

                HStack {
                    
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("Longer words ear 1 point per letter.")
                        
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)
                
                HStack {
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("Each puzzle includes at least one “pangram”")
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)
                
                HStack {
                    Image(systemName: "moonphase.new.moon")
                        .scaleEffect(0.4)
                    Text("“Pangrams” are worth an extra 7 points.")
                }
                .frame(width: geometry.size.width, alignment: .leading)
                .padding(.leading)
            }
            .navigationTitle("How To Play")
            .background(Color(red: 0.933, green: 0.933, blue: 0.933))
        }
    }
}

#Preview {
    HowToPlayView()
}
