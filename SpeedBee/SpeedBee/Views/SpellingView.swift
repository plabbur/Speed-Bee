//
//  SpellingView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct SpellingView: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    @State private var sizeVal: CGFloat = 95
//    @State private var textInput: String = ""
    @FocusState private var isFocused: Bool


    var centerColor: Color = Color(red: 0.967, green: 0.851, blue: 0.241)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                TopMenu()
                    .frame(height: 20)
                    .padding(.bottom, 10)
                
                Divider()

                // TIMER AND HINTS
                TimerHintsView()
                    .padding(.top, 6)
                    .padding(.bottom, -100)

                ZStack {
                    WordsFound()
                        .zIndex(1)
                        .padding(.bottom)
                    
                    TextField((dataModel.showHint ? dataModel.hintChars : ""), text: $dataModel.currentWord)
                        .focused($isFocused)
                        .frame(width: 300, height: 30)
                        .autocapitalization(.allCharacters)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .accentColor(.yellow)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .onChange(of: dataModel.currentWord) { newValue in
                            do {
                                if dataModel.currentWord.count > 20 {
                                    dataModel.currentWord = String(dataModel.currentWord.uppercased())
                                    dataModel.currentWord = ""
                                }
                            }
                        }
                        .onAppear {
                            isFocused = true
    //                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    
                    
//                    KeyboardView(textInput: $dataModel.currentWord)
//                        .padding(.top, 150)
//                        .overlay(
//                            VStack {
//                                if dataModel.newWord {
//                                    if dataModel.errorFound {
//                                        ErrorMessage(errorMessage: dataModel.getErrorMessage())
//                                            .padding(.bottom, 14)
//                                    } else {
//                                        ComplimentView()
//                                    }
//                                }
//                            }
//                                .padding(.bottom, 450)
//                        )
                }
                .padding(.top, -300)
            }
        }
    }
}

struct SpellingView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingView()
            .environmentObject(SpeedBeeDataModel())
    }
}
