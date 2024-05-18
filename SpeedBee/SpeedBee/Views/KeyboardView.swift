import SwiftUI
import AVFoundation

struct KeyboardView: View {
        
    @EnvironmentObject var dataModel: SpeedBeeDataModel
    @FocusState private var isFocused: Bool
    @State var textInput: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let axisX: CGFloat = 62

            VStack {
                TextField((dataModel.showHint ? dataModel.hintChars : ""), text: $textInput)
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
                    .onChange(of: textInput) { newValue in
                        do {
                            if textInput.count > 20 {
                                dataModel.enterWord(word: textInput)
                            }
                        }
                    }
                    .onAppear {
                        isFocused = false
                    }
                    
                
                ZStack {
                    HStack {
                        VStack {
                            
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[5], textInput: $textInput)
                                .position(x: 55 + axisX, y: 82)
                            
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[4], textInput: $textInput)
                                .position(x: 55 + axisX, y: -19)
                        }
                        
                        VStack {
                            
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[0], textInput: $textInput)
                                    .position(x: 0 + axisX, y: 38)
                            
                            CustomButtonView(imageName: "PolygonYellow", text: dataModel.letterCenter, textInput: $textInput)
                                    .position(x: 0 + axisX, y: 0)
                            
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[3], textInput: $textInput)
                                .position(x: 0 + axisX, y: -38)

                        }
                        
                        VStack {
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[1], textInput: $textInput)
                                .position(x: -55 + axisX, y: 82)
                            
                            CustomButtonView(imageName: "Polygon", text: dataModel.lettersOther[2], textInput: $textInput)
                                .position(x: -55 + axisX, y: -19)
                        }
                        
                    }
                    .frame(width: 390, height: 370)
                    
                    
                    HStack {
                        
                        Button("Delete") {
                            deleteLastCharacter()
                        }
                        .padding(.horizontal)
                        .frame(width: 84.0, height: 40.0)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
                        )
                        
                        Button(action: {
                            dataModel.shuffleLetters()
                        }) {
                            Image("uiw_reload")
                                .padding()
                                .frame(width: 40.0, height: 40.0)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal)
                        
                        Button("Enter") {
                            if textInput != "" {
                                dataModel.enterWord(word: textInput)
                            }
                            
                            textInput = ""
                        }
                        .padding(.horizontal)
                        .frame(width: 84.0, height: 40.0)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 0.906, green: 0.906, blue: 0.906), lineWidth: 1)
                        )
                    }
                    .padding(.top, 250)
                }
            }
            .frame(width: geometry.size.width, alignment: .center)
        }
    }
    
    
    private func deleteLastCharacter() {
        if !textInput.isEmpty {
            textInput.removeLast()
            dataModel.showHint = false
        }
    }
}

struct CustomButtonView: View {
    
    @EnvironmentObject var dataModel: SpeedBeeDataModel

    var imageName: String
    var text: String
    @Binding var textInput: String
    
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
                        
                        textInput += text
                    }
                }
        }
    }
}


#Preview {
    KeyboardView()
        .environmentObject(SpeedBeeDataModel())
}


