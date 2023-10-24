//
//  CALayer+Ext.swift
//  START-HW12-Arken
//
//  Created by Arken Sarsenov on 24.10.2023.
//

import UIKit
public extension CALayer {
    var isAnimationsPaused: Bool {
        return speed == 0.0
    }
    func startAnimation(timer: Int) {
        let progressBarAnimation = CABasicAnimation(keyPath: "strokeEnd")
        progressBarAnimation.toValue = 1
        progressBarAnimation.duration = TimeInterval(timer)
        progressBarAnimation.fillMode = .forwards
        progressBarAnimation.isRemovedOnCompletion = true
        add(progressBarAnimation, forKey: "animation")
    }
    func pauseAnimations() {
        if !isAnimationsPaused {
            let currentTime = CACurrentMediaTime()
            let pausedTime = convertTime(currentTime, from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }
    func resumeAnimations() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let currentTime = CACurrentMediaTime()
        let timeSincePause = convertTime(currentTime, from: nil) - pausedTime
        beginTime = timeSincePause
    }
    func resetAnimation() {
        removeAnimation(forKey: "animation")
    }
}
