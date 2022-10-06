//
//  LoginScreen.swift
//  UBER Clone
//
//  Created by Dalveer singh on 06/10/22.
//

import SwiftUI

struct LoginScreen: View {
    @State var emailId:String = ""
    @State var password:String = ""
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
            Rectangle()
                .opacity(0.8)
            VStack(spacing:12){
                Text("UBER")
                    .font(.system(size: 39, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                HStack{Spacer()}
                HStack{Spacer()}
                HStack{Spacer()}
                TextField("Email",text: $emailId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Enter your Password",text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    
                } label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .frame(width:400,height: 40)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }
                Button {
                    
                } label: {
                    Text("Forgot Password ?")
                        .font(.system(size: 19,weight: .regular))
                        .foregroundColor(.white)
                }

            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
