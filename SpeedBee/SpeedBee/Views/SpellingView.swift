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
    @FocusState private var isFocused: Bool

    var centerColor: Color = Color(red: 0.967, green: 0.851, blue: 0.241)
    
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                TopMenuView()
                    .frame(height: 20)
                    .padding(.bottom, 10)
                
                Divider()

                TimerHintsView()
                    .padding(.top, 6)
                    .padding(.bottom, -100)
                
                ZStack {
                    WordsFoundView()
                        .zIndex(1)
                        .padding(.bottom)
                    
                    KeyboardView()
                        .padding(.top, 150)
                        .overlay(
                            VStack {
                                if dataModel.newWord {
                                    if dataModel.errorFound {
                                        ErrorMessage(errorMessage: dataModel.getErrorMessage())
                                            .padding(.bottom, 14)
                                    } else {
                                        ComplimentView()
                                    }
                                }
                            }
                            .padding(.bottom, 450)
                        )
                }
                .padding(.top, -300)
            }
            .overlay(
                dataModel.timePause ? AnyView(PauseView()) : AnyView(EmptyView())
            )
            .overlay(
                dataModel.gameOver ? AnyView(EndgameView()) : AnyView(EmptyView())
            )
            .overlay(
                dataModel.gameOverConfirm ? AnyView(GameOverConfirmView()) : AnyView(EmptyView())
            )
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    SpellingView()
        .environmentObject(SpeedBeeDataModel())
}
