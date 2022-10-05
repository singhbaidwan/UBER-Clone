//
//  RideType.swift
//  UBER Clone
//
//  Created by Dalveer singh on 04/10/22.
//

import Foundation
enum RideType:Int,CaseIterable,Identifiable{
    case uberX
    case black
    case uberXL
    var id:Int{
        return rawValue
    }
    var description:String{
        switch self {
        case .uberX:
            return "UberX"
        case .black:
            return "UberBlack"
        case .uberXL:
            return "UberXL"
        }
    }
    var imageName:String{
        switch self {
        case .uberX:
            return "uber-x"
        case .black:
            return "uber-black"
        case .uberXL:
            return "uber-x"
        }
    }
    var baseFare:Double{
        switch self {
        case .uberX:
            return 5
        case .black:
            return 20
        case .uberXL:
            return 10
        }
    }
    func computePrice(for distanceInMetres:Double)->Double{
        let distanceInKm = distanceInMetres/1000
        switch self {
        case .uberX:
            return distanceInKm * 1.5 + baseFare
        case .black:
            return distanceInKm*2.0 + baseFare
        case .uberXL:
            return distanceInKm*1.75 + baseFare
        }
    }
}
