//
//  StatsView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 5/6/24.
//

import SwiftUI

struct StatsView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @State var backgroundOffset: CGFloat = -2.5
    @State var scrollToID: Double? = nil
    @State private var menuOffset: CGFloat = -2.5
    @State var timeSelected = 30
    @State var timeIndex: Int = 0
    var timesToSelect: [Int] = [30, 60, 120, 300, 600, 100000]
    var yOffset: CGFloat = 20
    var navTitle: Bool = false

    var body: some View {
        GeometryReader { geometry in
            
            NavigationView {
                
                VStack {
                    
                    if !navTitle {
                        Text("Statistics")
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                    }
                    
                    
                    ZStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { scrollView in
                                HStack {
                                    Button(action: {
                                        backgroundOffset = -2.5
                                        timeSelected = 30
                                    }) {
                                        Text("0:30")
                                    }
                                    .padding(.horizontal, 20)
                                    .foregroundColor(backgroundOffset == -2.5 ? .yellow : .gray)
                                    .id(-2.5)
                                    
                                    Button(action: {
                                        backgroundOffset = -1.5
                                        timeSelected = 60
                                    }) {
                                        Text("1:00")
                                    }
                                    .padding(.horizontal, 20)
                                    .foregroundColor(backgroundOffset == -1.5 ? .yellow : .gray)
                                    .id(-1.5)
                                    
                                    Button(action: {
                                        backgroundOffset = -0.5
                                        timeSelected = 120
                                    }) {
                                        Text("2:00")
                                    }
                                    .padding(.horizontal, 20)
                                    .foregroundColor(backgroundOffset == -0.5 ? .yellow : .gray)
                                    .id(-0.5)
                                    
                                    Button(action: {
                                        backgroundOffset = 0.5
                                        timeSelected = 300
                                    }) {
                                        Text("5:00")
                                    }
                                    .padding(.horizontal, 20)
                                    .foregroundColor(backgroundOffset == 0.5 ? .yellow : .gray)
                                    .id(0.5)
                                    
                                    Button(action: {
                                        backgroundOffset = 1.5
                                        timeSelected = 600
                                    }) {
                                        Text("10:00")
                                    }
                                    .padding(.horizontal, 20)
                                    .foregroundColor(backgroundOffset == 1.5 ? .yellow : .gray)
                                    .id(1.5)
                                    
                                    Button(action: {
                                        backgroundOffset = 2.5
                                        timeSelected = 100000
                                    }) {
                                        Text("Unlimited")
                                    }
                                    .padding(.horizontal, 20)
                                    .foregroundColor(backgroundOffset == 2.5 ? .yellow : .gray)
                                    .id(2.5)
                                }
                                .fontWeight(.bold)
                                .onChange(of: backgroundOffset) { id in
                                    
                                    scrollToID = backgroundOffset
                                    
                                    if let id = scrollToID {
                                        withAnimation {
                                            scrollView.scrollTo(id, anchor: .center)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: 30)
                        .overlay {
                            if backgroundOffset != -2.5 {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 150, height: 30)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.white).opacity(0)]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .position(x: 50, y: 15)
                                    .allowsHitTesting(false)
                            }
                            
                            if backgroundOffset != 2.5 {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 150, height: 30)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [Color(.white), Color(.white).opacity(0)]), startPoint: .trailing, endPoint: .leading)
                                    )
                                    .position(x: geometry.size.width - 50, y: 15)
                                    .allowsHitTesting(false)
                            }
                        }
                    }
                    .position(x: geometry.size.width / 2, y: yOffset)
                    
                    HStack(spacing: 0) {
                        
                        ForEach([30, 60, 120, 300, 600, 100000], id: \.self) { timeSelect in
                            StatsPageView(timeSelect: timeSelect)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                        
                    }
                    .position(x: geometry.size.width / 2, y: yOffset + (navTitle ? 23 : 38))
                    .offset(x: -(self.backgroundOffset * geometry.size.width))
                    .animation(.default)
                    .gesture(
                        DragGesture()
                            .onEnded({ value in
                                if value.translation.width > 10 {
                                    if self.backgroundOffset > -2 {
                                        self.backgroundOffset -= 1
                                        timeIndex -= 1
                                        
                                    }
                                } else if value.translation.width < -10 {
                                    if self.backgroundOffset < 2 {
                                        self.backgroundOffset += 1
                                        timeIndex += 1
                                    }
                                }
                                timeSelected = timesToSelect[timeIndex]
                                
                            })
                    )
                    
                }
            }
        }
    }
}

#Preview {
    StatsView()
        .environmentObject(SpeedBeeDataModel())
}
