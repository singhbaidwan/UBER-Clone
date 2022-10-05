//
//  Double.swift
//  UBER Clone
//
//  Created by Dalveer singh on 05/10/22.
//

import Foundation
extension Double{
    private var currencyFormatter:NumberFormatter{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_IN")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    func toCurrency()->String{
        return currencyFormatter.string(for: self) ?? ""
    }
}
