//
//  WordsFound.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct WordsFound: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @State private var isExpanded: Bool = false
    
    var wordsFound: [String] = ["Chimpanzee", "Ardvark", "Elephant", "Baboon", "Coyote", "Dragon"]
    
    var body: some View {
        
        GeometryReader { geometry in

            ZStack {
                // WORDS FOUND
                DisclosureGroup(isExpanded: $isExpanded) {
                    ZStack {
                        List {
                            ForEach(dataModel.wordsFound.sorted(), id: \.self) { item in
                                Text(item.capitalized)
                                    .foregroundColor(.black)
                                    .fontWeight(dataModel.isPangram(word: item) ? .bold : .regular)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .frame(width: geometry.size.width - 75, height: 530)
                        .background(.white)
                    }
               
                } label: {
                    if !isExpanded {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(dataModel.wordsFound.reversed(), id: \.self) { item in
                                    Text(item.capitalized)
                                        .foregroundColor(.black)
                                        .fontWeight(dataModel.isPangram(word: item) ? .bold : .regular)
                                }
                                .background(Color.white)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: 20)

                        
                    } else {
                        if dataModel.wordsFound.count == 1 {
                            Text("You have found \(dataModel.wordsFound.count) word")
                                .foregroundColor(.black)
                        } else {
                            Text("You have found \(dataModel.wordsFound.count) words")
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.top, 5)
                .padding(.horizontal, 20)
                .padding(.bottom, 5)
                .accentColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 2)
                )
                .padding()
            }
        }
    }
}


struct WordsFound_Previews: PreviewProvider {
    static var previews: some View {
        WordsFound()
            .environmentObject(SpeedBeeDataModel())
    }
}
