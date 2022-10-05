//
//  HomeView.swift
//  UBER Clone
//
//  Created by Dalveer singh on 02/10/22.
//

import SwiftUI

struct HomeView: View {
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel:LocationSearchViewModel
    var body: some View {
        ZStack(alignment:.bottom){
            ZStack(alignment:.top){
                UberMapViewRepresentable(mapState:$mapState)
                    .ignoresSafeArea()
                if mapState == .searchingForLocation{
                    LocationSearchView(mapState: $mapState)
                }
                else if mapState == .noInput{
                    
                locationSeachActivationView()
                    .padding(.top,72)
                    .onTapGesture {
                        withAnimation(.spring())
                        {
                            mapState = .searchingForLocation
                        }
                    }
                }
                MapViewActionButton(mapState: $mapState )
                    .padding(.leading)
                    .padding(.top,4)
            }
            if mapState == .locationSelected || mapState == .polyLineAdded{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
//                print("DEBUG : The location of user in Home View is \(location)")
                locationViewModel.userLocation = location
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
