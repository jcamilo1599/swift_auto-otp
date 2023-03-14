//
//  ContentView.swift
//  AutoOTP
//
//  Created by Juan Camilo Marín Ochoa on 13/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var OTPValue = ""
    @FocusState private var isKeyboardShowing: Bool
    @State private var showAlert = false
    
    var body: some View {
        VStack{
            buildFields()
            buildButton()
                .padding(.top)
        }
        .padding(.all)
    }
    
    // MARK: campos de texto
    func buildFields() -> some View {
        HStack {
            ForEach(0..<6, id: \.self) { index in
                buildOTPField(index)
            }
        }
        .background(content: {
            TextField("", text: $OTPValue.limit(6))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 0, height: 0)
                .opacity(0)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
        })
        .contentShape(Rectangle())
        .onTapGesture {
            isKeyboardShowing.toggle()
        }
    }
    
    // MARK: botón
    func buildButton() -> some View {
        Button {
            showAlert = true
        } label: {
            Text("CONTINUAR")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical,12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                }
        }
        .disableWithOpacity(OTPValue.count < 6)
        .alert("El OTP es \(OTPValue)", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    // MARK: campos de cada caracter
    @ViewBuilder
    func buildOTPField(_ index: Int) -> some View {
        ZStack {
            if OTPValue.count > index {
                // Busca el caracter en el índice
                let startIndex = OTPValue.startIndex
                let charIndex = OTPValue.index(startIndex, offsetBy: index)
                let charToString = String(OTPValue[charIndex])
                
                Text(charToString)
            } else {
                Text("")
            }
        }
        .frame(width: 52, height: 52)
        .background {
            // Determina si el teclado se muestra y si el contador del OTP es es del campo actual
            let status = (isKeyboardShowing && OTPValue.count == index)
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(status ? Color.primary : Color.gray,lineWidth: status ? 1 : 0.5)
                .animation(.easeIn(duration: 0.1), value: isKeyboardShowing)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
