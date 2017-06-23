//
//  GameScene.swift
//  Clock
//
//  Created by Yujin Ariza on 4/20/16.
//  Copyright (c) 2016 Make School. All rights reserved.
//

import SpriteKit

func degreesToRadians(_ degrees: Double) -> CGFloat {
    return CGFloat(degrees * M_PI / 180)
}

open class GameScene: SKScene {
    var timeLabel: SKLabelNode?
    var hourHand: SKNode?
    var minuteHand: SKNode?
    var secondHand: SKNode?
    
    let clockFace = ClockFace()
    
    override open func didMove(to view: SKView) {
        timeLabel = childNode(withName: "timeLabel") as? SKLabelNode
        
        let clock = childNode(withName: "clock")!
        
        hourHand = clock.childNode(withName: "hourHand")
        hourHand?.zPosition = 10
        minuteHand = clock.childNode(withName: "minuteHand")
        minuteHand?.zPosition = 10
        secondHand = clock.childNode(withName: "secondHand")
        secondHand?.zPosition = 10
        
        updateTime()

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.updateTime), userInfo: nil, repeats: true)
    }
    
    func updateTime() {
        clockFace.updateDate()
        
        let hours = clockFace.calendar.component(.hour, from: clockFace.date) % 12
        let minutes = clockFace.calendar.component(.minute, from: clockFace.date)
        let seconds = clockFace.calendar.component(.second, from: clockFace.date)
        
        let timeString = "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        timeLabel?.text = "The time is \(timeString)"
        
        hourHand?.zRotation = -degreesToRadians(clockFace.getHourHandDegrees())
        minuteHand?.zRotation = -degreesToRadians(clockFace.getMinuteHandDegrees())
        secondHand?.zRotation = -degreesToRadians(clockFace.getSecondHandDegrees())
    }
}
