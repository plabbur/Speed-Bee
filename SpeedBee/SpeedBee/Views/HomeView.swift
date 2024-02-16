//
//  HomeView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI


struct HomeView: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @State var navHome: Bool = true

    var body: some View {
        
        GeometryReader { geometry in
            NavigationView {
                ZStack {
                    VStack {
                        NavigationLink(destination: OptionsView()) {
                            Image("optionsButton")
                        }
                        .frame(width: geometry.size.width - 40, alignment: .trailing)
                        .padding(.bottom, 100)
                        .onTapGesture {
                            dataModel.onScreen = SpeedBeeDataModel.viewMode.OPTIONS
                        }
                        
                        Image("beeLogo")
                            .resizable() // Make the image resizable
                            .frame(width: 84, height: 104)
                            .padding(.top, 50.0)
                        Text("Speed Bee")
                            .font(.system(size: 40))
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding(.bottom, 2)
                        Text("Make as many words as you can before the time runs out!")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                            .frame(width: 300)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        if !dataModel.gameOver {
                            Button(action: { dataModel.onScreen = SpeedBeeDataModel.viewMode.GAME }) {
                                // Action to perform when the button is pressed
                                ZStack {
                                    Text("Continue Game")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                        .frame(height: 5)
                                        .padding(.bottom, 18)
                                    HStack {
                                        Image("clockIcon")
                                        Text(dataModel.minuteTimer())
                                            .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.37))
                                            .font(.system(size: 14))
                                    }
                                    .frame(height: 5)
                                    .padding(.top, 25)
                                }
                            }
                            .padding()
                            .frame(width: 300.0, height: 60)
                            .background(Color.yellow)
                            .cornerRadius(30)
                            .padding(.bottom, 8)
                            .fontWeight(.heavy)
                            .shadow(
                                color: Color(red: 0.97, green: 0.85, blue: 0.24, opacity: 0.40), radius: 16.80, y: 3
                            )
                        }
                        
                        Button("New Game") {
                            dataModel.showLevels = true
                        }
                        .padding()
                        .frame(width: 300.0, height: 60)
                        .background(Color.white)
                        .foregroundColor(.yellow)
                        .cornerRadius(30)
                        .padding(.bottom, 20)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .shadow(
                            color: Color(red: 0.97, green: 0.85, blue: 0.24, opacity: 0.40), radius: 16.80, y: 3
                        )
                        .padding(.bottom, 10)
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color(red: 0.97, green: 0.85, blue: 0.24).opacity(0.02), Color(red: 0, green: 0, blue: 0).opacity(0.02), Color(red: 0, green: 0, blue: 0).opacity(0.02)]), startPoint: .top, endPoint: .bottom)
                    )
                    
                }
                
            }
            
            
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SpeedBeeDataModel())
    }
}

