//
//  RegisterScreen.swift
//  UBER Clone
//
//  Created by Dalveer singh on 06/10/22.
//

import SwiftUI

struct RegisterScreen: View {
    @State private var email:String = ""
    @State private var username:String = ""
    @State private var fullname:String = ""
    @State private var password:String = ""
    var body: some View {
        ZStack(alignment:.center){
            Image("background")
                .resizable()
            Rectangle()
                .opacity(0.7)
            VStack(spacing:30)
            {
                Text("UBER")
                    .font(.system(size: 39, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                HStack{Spacer()}
                TextField("Enter Email",text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter UserName",text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Enter Full Name",text: $fullname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Enter password",text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button {
                    
                } label: {
                    Text("Register")
                        .font(.headline)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .frame(width:400,height: 40)
                        .background(Color(.systemBlue))
                        .cornerRadius(10)
                }

                
            }
            .padding(.horizontal,32)
            .padding(.top,44)
        }
        .ignoresSafeArea()
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
