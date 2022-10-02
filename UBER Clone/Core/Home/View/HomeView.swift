//
//  HomeView.swift
//  UBER Clone
//
//  Created by Dalveer singh on 02/10/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack(alignment:.top){
            UberMapViewRepresentable()
                .ignoresSafeArea()
            locationSeachActivationView()
                .padding(.top,72)
            MapViewActionButton()
                .padding(.leading)
                .padding(.top,4)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
