import SwiftUI
import AVFoundation

struct KeyboardView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let axisX: CGFloat = 62
            VStack {
                ZStack {
                    // HEXAGONS
                    HStack {
                        // LEFT SIDE
                        VStack {
                            
                            // TOP LEFT
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[5])
                                .position(x: 55 + axisX, y: 82)
                            
                            // BOTTOM LEFT
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[4])
                                .position(x: 55 + axisX, y: -19)
                        }
                        
                        // MIDDLE
                        VStack {
                            
                            // TOP MIDDLE
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[0])
                                .position(x: 0 + axisX, y: 38)
                            
                            // CENTER MIDDLE
                            CustomButtonView(imageName: "PolygonYellow", text: dataModel.letterCenter)
                                .position(x: 0 + axisX, y: 0)
                            
                            // BOTTOM MIDDLE
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[3])
                                .position(x: 0 + axisX, y: -38)
                            
                        }
                        
                        // RIGHT SIDE
                        VStack {
                            // TOP RIGHT
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[1])
                                .position(x: -55 + axisX, y: 82)
                            
                            // BOTTOM RIGHT
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[2])
                                .position(x: -55 + axisX, y: -19)
                        }
                        
                    }
                    .frame(width: 390, height: 370)
                    
                    
//                     BOTTOM BUTTONS
//                    HStack {
//                        
//                        Button("Delete") {
//                            deleteLastCharacter()
//                        }
//                        .padding(.horizontal)
//                        .frame(width: 84.0, height: 40.0)
//                        .foregroundColor(.black)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
//                        )
//                        
//                        Button(action: {
//                            dataModel.shuffleLetters()
//                        }) {
//                            Image("uiw_reload")
//                                .padding()
//                                .frame(width: 40.0, height: 40.0)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
//                                )
//                        }
//                        .padding(.horizontal)
//                        
//                        Button("Enter") {
//                            if textInput != "" {
//                                dataModel.enterWord(word: dataModel.currentWord)
//                            }
//                            
//                            textInput = ""
//                        }
//                        .padding(.horizontal)
//                        .frame(width: 84.0, height: 40.0)
//                        .foregroundColor(.black)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
//                        )
//                    }
//                    .padding(.top, 250)
                }
            }
            .frame(width: geometry.size.width, alignment: .center)
        }
    }
    
    private func deleteLastCharacter() {
        if !dataModel.currentWord.isEmpty {
            dataModel.currentWord.removeLast()
            dataModel.showHint = false
        }
    }
}

struct CustomButtonView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel

    var imageName: String
    var text: String
    
    @State private var sizeVal: CGFloat = 1.0
    @State private var isLongPressing = false

    var body: some View {
        Button(action: {
            print("tapped")
            dataModel.showHint = false
        }) {
            Image(imageName)
                .scaleEffect(sizeVal)
                .overlay(
                    Text(text)
                        .foregroundColor(.black)
                        .font(.system(size: 27))
                        .fontWeight(.semibold)
                )
                .onLongPressGesture(minimumDuration: 10, pressing: { isPressed in
                    withAnimation(Animation.easeInOut(duration: 0.1)) {
                        self.sizeVal = isPressed ? 0.85 : 1.0
                        self.isLongPressing = isPressed
                    }
                }) {
                    
                }
                .onChange(of: isLongPressing) { newValue in
                    if !newValue {
                        withAnimation {
                            self.sizeVal = 1.0
                        }
                        
                        if dataModel.soundsOn {
                            AudioServicesPlaySystemSound(1104)
                        }
                        
                        dataModel.addToCurrentWord(text)
                    }
                }
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
            .environmentObject(SpeedBeeDataModel())
    }
}
