//
//  ClockFace.swift
//  Clock
//
//  Created by Yujin Ariza on 4/21/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation

open class ClockFace {
    
    var date: Date = Date()
    let calendar: Calendar = Calendar.current
    
    func updateDate() {
        date = Date()
    }
    
    func getHourHandDegrees() -> Double {
        let hour: Int = calendar.component(.hour, from: date) % 12
        let minute = calendar.component(.minute, from: date)
        let second: Int = calendar.component(.second, from: date)
        return Double(hour) * (360 / 12) + Double(minute) * (360 / 12 / 60) + Double(second) * (360 / 12 / 60 / 60)
    }
    
    func getMinuteHandDegrees() -> Double {
        let minute: Int = calendar.component(.minute, from: date)
        let second: Int = calendar.component(.second, from: date)
        return Double(minute) * (360 / 60) + Double(second) * (360 / 60 / 60)
    }
    
    func getSecondHandDegrees() -> Double {
        let second: Int = calendar.component(.second, from: date)
        return Double(second) * (360 / 60)
    }
}
