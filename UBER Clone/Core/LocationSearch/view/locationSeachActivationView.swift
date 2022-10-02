//
//  locationSeachActivationView.swift
//  UBER Clone
//
//  Created by Dalveer singh on 02/10/22.
//

import SwiftUI

struct locationSeachActivationView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal)
            Text("Where to ?")
                .foregroundColor(Color(.darkGray))
            Spacer()
            
        }
        .frame(width:UIScreen.main.bounds.width-64,
               height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color:.black,radius: 6)
            
        )
    }
}

struct locationSeachActivationView_Previews: PreviewProvider {
    static var previews: some View {
        locationSeachActivationView()
    }
}
