//
//  RideRequestView.swift
//  UBER Clone
//
//  Created by Dalveer singh on 04/10/22.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width:48,height: 6)
                .padding(.top,8)
            // trip info view
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width:8,height:8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width:1,height: 32)
                    Rectangle()
                        .fill(.black)
                        .frame(width:8,height: 8)
                }
                VStack(alignment:.leading,spacing: 24){
                    HStack{
                        Text("Current Location")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom,10)
                    HStack{
                        Text("My house")
                            .font(.system(size: 16,weight: .semibold))
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14,weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding(.leading,4)
            }
            .padding()
            
            Divider()
            
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth:.infinity,alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing:12)
                {
                    ForEach(0..<3,id:\.self)
                    {
                        _ in
                        VStack(alignment:.leading){
                            Image("uber-x")
                                .resizable()
                                .scaledToFit()
                            VStack(spacing: 4){
                                Text("Uber - x")
                                    .font(.system(size: 14,weight: .semibold))
                                Text("Rs. 5000")
                                    .font(.system(size: 14,weight: .semibold))
                            }
                            .padding(8)
                        }
                        .frame(width:120,height: 140)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            Divider()
                .padding(.vertical,8)
            HStack(spacing:12)
            {
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                 Text("****1234")
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
                
            }
            .frame(height:50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width:UIScreen.main.bounds.width-32,height:50)
                    .background(.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }

            
        }
        .padding(.bottom,24)
        .background(.white)
        .cornerRadius(12)
        
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
