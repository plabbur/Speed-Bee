//
//  NavView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct NavView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    
    @State var navHome: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                if dataModel.onScreen == SpeedBeeDataModel.viewMode.GAME {
                    SpellingView()
                } else {
                    TabView {
                        HomeView()
                            .onAppear(perform: { dataModel.onScreen = SpeedBeeDataModel.viewMode.HOME })
                            .tabItem {
                                Label("Main", image: dataModel.onScreen == SpeedBeeDataModel.viewMode.HOME ? "mainFill" : "mainUnfill")
                            }
                        StatsView()
                            .onAppear(perform: { dataModel.onScreen = SpeedBeeDataModel.viewMode.STATISTICS })
                            .tabItem {
                                Label("Stats", image: dataModel.onScreen == SpeedBeeDataModel.viewMode.STATISTICS ? "statsFill" : "statsUnfill")
                            }
                    }
                    .accentColor(.yellow)
                    .onAppear {
                        let appearance = UITabBarAppearance()
                        appearance.backgroundColor = UIColor(Color.white)
                        
                        UITabBar.appearance().standardAppearance = appearance
                        UITabBar.appearance().scrollEdgeAppearance = appearance
                    }
                    .overlay(
                        dataModel.showLevels ? AnyView(ChooseLevelView()) : AnyView(EmptyView())
                    )
                }
            }
            .accentColor(.yellow)
        }
    }
}


#Preview {
    NavView()
        .environmentObject(SpeedBeeDataModel())
}
