//
//  LocationSearchView.swift
//  UBER Clone
//
//  Created by Dalveer singh on 02/10/22.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @State private var destinationLocationText = ""
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width:6,height:6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width:1,height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width:6,height: 6)
                }
                VStack{
                    TextField("Current Location",text: $startLocationText)
                        .frame(height:32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                    
                    TextField("Where to ?",text: $destinationLocationText)
                        .frame(height:32)
                        .background(Color(.systemGray2))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top,64)
            Divider()
                .padding(.vertical)
            ScrollView{
                VStack(alignment:.leading){
                    ForEach(0..<20,id:\.self){
                        _ in
                        LocationSearchResultCell()
                    }
                }
            }
        }
        .background(.white)
        
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
