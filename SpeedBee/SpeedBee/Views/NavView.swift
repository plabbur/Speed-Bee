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
                TabView {
                    HomeView()
                        .onAppear(perform: { navHome = true })
                        .tabItem {
                            Label("Main", image: navHome ? "mainFill" : "mainUnfill")
                        }
                    StatsView(/* navTitle: false */)
                        .onAppear(perform: { navHome = false })
                        .tabItem {
                            Label("Stats", image: !navHome ? "statsFill" : "statsUnfill")
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
            .accentColor(.yellow)
        }
    }
}


#Preview {
    NavView()
        .environmentObject(SpeedBeeDataModel())
}
