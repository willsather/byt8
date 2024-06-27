//
//  Extensions.swift
//  byt8
//
//  Created by Will Sather on 7/4/21.
//

import Foundation

extension Date {
    func subtract(years: Int) -> Date {
        let result =  Calendar.current.date(byAdding: .year, value: -(years), to: self)
        return result!
    }
}
