//
//  Utilies.swift
//  Converter
//
//  Created by Яна Шебеко on 25.10.22.
//

import Foundation

extension String{
    static let numberFormatter = NumberFormatter()
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result = String.numberFormatter.number(from: self){
            return result.doubleValue
        }
        else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self){
                return result.doubleValue
            }
        }
        return 0
    }
}
