//
//  HowToPlayView.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

struct HowToPlayView: View {
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var backgroundOffset: CGFloat = -3
    @State var yOffset: CGFloat = 175
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    HStack(spacing: 0) {
                        
                        ImageTextView(image: "1 graphic", text: "Words must contain at least 4 letters")
                            .frame(width: geometry.size.width)
                        
                        ImageTextView(image: "2 graphic", text: "Words must include the center letter")
                            .frame(width: geometry.size.width)

                        ImageTextView(image: "3 graphic", text: "Words can’t include excess letters")
                            .frame(width: geometry.size.width)

                        ImageTextView(image: "4 graphic", text: "Four letter words are worth 1 point")
                            .frame(width: geometry.size.width)
                        
                        ImageTextView(image: "5 graphic", text: "Longer words are worth 1 point per letter")
                            .frame(width: geometry.size.width)

                        ImageTextView(image: "6 graphic", text: "Each puzzle contains at least one pangram, which is worth an extra 7 points")
                            .frame(width: geometry.size.width)

                    }
                    .position(y: yOffset)
                    .offset(x: -(backgroundOffset * geometry.size.width))
                    .animation(.default)
                    
                    
                    Button("Next") {
                        if backgroundOffset < 2 {
                            backgroundOffset += 1
                        }
                    }
                    .padding()
                    .frame(width: 200.0, height: 60)
                    .background(backgroundOffset < 2 ? Color.yellow : Color.clear)
                    .foregroundColor(backgroundOffset < 2 ? Color.white : Color.clear)
                    .cornerRadius(30)
                    .padding(.bottom, 20)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                    .position(x: geometry.size.width / 2, y: yOffset + 150)
                    
                    

                    
    //                HStack {
    //                    Image(backgroundOffset == -3 ? "filled elipse" : "white elipse")
    //                    Image(backgroundOffset == -2 ? "filled elipse" : "white elipse")
    //                    Image(backgroundOffset == -1 ? "filled elipse" : "white elipse")
    //                    Image(backgroundOffset == 0 ? "filled elipse" : "white elipse")
    //                    Image(backgroundOffset == 1 ? "filled elipse" : "white elipse")
    //                    Image(backgroundOffset == 2 ? "filled elipse" : "white elipse")
    //                }
    //                .position(x: geometry.size.width / 2, y: yOffset + 150)
                }
                .gesture(
                DragGesture()
                    .onEnded({ value in
                        if value.translation.width > 5 {
                            if backgroundOffset > -3 {
                                backgroundOffset -= 1
                            }
                        } else if value.translation.width < -5 {
                            if backgroundOffset < 2 {
                                backgroundOffset += 1
                            }
                        }
                    })
                )
            }
            
        }
    }
}


struct ImageTextView: View {
    
    var image: String
    var text: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(image)
                    .padding(.bottom, 50)
                    .frame(width: geometry.size.width, alignment: .center)
                    .fixedSize(horizontal: false, vertical: false)
                    .scaleEffect(CGSize(width: 0.9, height: 0.9))
                Text(text)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width - 125, alignment: .centerLastTextBaseline)
            }
        }
    }
}


#Preview {
    HowToPlayView()
        .environmentObject(SpeedBeeDataModel())
}
