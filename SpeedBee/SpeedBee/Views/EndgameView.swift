//
//  EndgameView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/15/24.
//

import SwiftUI
import AVFoundation

struct EndgameView: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    ScrollView {
                        VStack {
                            Image("beeLogo")
                                .resizable()
                                .frame(width: 84, height: 104)
                                .padding(.top, 50.0)
                            Text("Game Over!")
                                .font(.system(size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Text(dataModel.mistakeCounter == 3 ? "No mistakes left" : "No time left")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .padding(.bottom, 50)
                            
                            HStack {
                                Spacer()
                                Text("Statistics")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                
                                NavigationLink(destination: StatsView(navTitle: true).navigationTitle("Statistics")) {
                                    ZStack() {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 85, height: 31)
                                            .background(Color(red: 1, green: 1, blue: 1).opacity(0.25))
                                            .cornerRadius(15.50)
                                            .offset(x: 0, y: 0)
                                        Text("See All")
                                            .font(.system(size: 18))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .offset(x: -0.50, y: 0.50)
                                    }
                                }
                                
                                
                                Spacer()
                                
                            }
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 350, height: 120)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 1, blue: 1).opacity(0.25), Color(red: 1, green: 1, blue: 1).opacity(0.25)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .cornerRadius(20)
                                
                                VStack {
                                    
                                    HStack {
                                        Image("pointsIcon")
                                            .padding(.leading, 40)
                                        Text("Points")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Text("\(dataModel.pointsReceived)")
                                            .padding(.horizontal, 40)
                                            .fontWeight(.bold)
                                    }
                                    Divider()
                                        .foregroundColor(.white)
                                        .frame(width: 295)
                                        .offset(x: 28)
                                        .padding(.vertical, 4)
                                    
                                    HStack {
                                        Image("wordsIcon")
                                            .padding(.leading, 40)
                                        
                                        Text("Words")
                                            .font(.system(size: 18))
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        Text("\(dataModel.wordsFound.count)")
                                            .padding(.horizontal, 40)
                                            .fontWeight(.bold)
                                    }
                                    
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            }
                            .padding(.bottom)
                            
                            HStack {
                                Spacer()
                                Text("Words")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                                Spacer()
                            }
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 350, height: 300)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 1, blue: 1).opacity(0.25), Color(red: 1, green: 1, blue: 1).opacity(0.25)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(20)
                                .overlay(
                                    List {
                                        ForEach(dataModel.wordsFound.sorted(), id: \.self) { item in
                                            Text(item.capitalized)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.leading)
                                                .fontWeight(dataModel.isPangram(word: item) ? .black : .semibold)
                                        }
                                        .listRowBackground(Color.clear)
                                        
                                    }
                                        .listStyle(PlainListStyle())
                                        .scrollContentBackground(.hidden)
                                        .padding(.horizontal)
                                        .padding(.vertical)
                                )
                        }
                    }
                    
                    Button("New Game") {
                        dataModel.showLevels = true
                    }
                    .padding()
                    .frame(width: 300.0)
                    .background(Color.white)
                    .foregroundColor(Color(red: 0.74, green: 0.65, blue: 0.18))
                    .fontWeight(.bold)
                    .cornerRadius(30)
                    .padding(.bottom, 8)
                    
                    Button("Main") {
                        dataModel.onScreen = SpeedBeeDataModel.viewMode.HOME
                    }
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    
                }
                .background(Color("mainYellow"))
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .accentColor(.yellow)
            .onAppear {
                if dataModel.soundsOn {
                    AudioServicesPlaySystemSound(1029)
                }
            }
            .overlay(
                dataModel.showLevels ? AnyView(ChooseLevelView()) : AnyView(EmptyView())
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    EndgameView()
        .environmentObject(SpeedBeeDataModel())
}
