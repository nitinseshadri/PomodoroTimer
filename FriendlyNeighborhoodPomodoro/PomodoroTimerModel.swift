//
//  PomodoroTimerModel.swift
//  FriendlyNeighborhoodPomodoro
//
//  Created by Nitin Seshadri on 4/9/21.
//  Copyright © 2021 Nitin Seshadri. All rights reserved.
//

import Cocoa

class PomodoroTimerModel: NSObject, ObservableObject {
    
    public static let defaultPomodoroTime: TimeInterval = 25 * 60 // 25 minutes
    public static let defaultBreakTime: TimeInterval = 5 * 60 // 5 minutes
    public static let defaultLongBreakTime: TimeInterval = 15 * 60 // 15 minutes
    
    public enum PomodoroTimerMode {
        case pomodoro
        case scheduledBreak
        case longBreak
    }
    
    public enum PomodoroTimerState {
        case reset
        case running
        case paused
    }
    
    @Published var pomodoroTime = PomodoroTimerModel.defaultPomodoroTime
    @Published var breakTime = PomodoroTimerModel.defaultBreakTime
    @Published var longBreakTime = PomodoroTimerModel.defaultLongBreakTime
    
    @Published fileprivate(set) var timerState: PomodoroTimerState = .reset
    @Published fileprivate(set) var timerMode: PomodoroTimerMode = .pomodoro
    @Published fileprivate(set) var timeRemaining: TimeInterval = PomodoroTimerModel.defaultPomodoroTime
    
    fileprivate var timer: Timer?

    override init() {
        super.init()
        
    }
    
    public func resetTimer(mode: PomodoroTimerMode) {
        self.timer?.invalidate()
        self.timer = nil
        self.timerState = .reset
        self.timerMode = mode
        switch (self.timerMode) {
        case .pomodoro:
            self.timeRemaining = pomodoroTime
            break
        case .scheduledBreak:
            self.timeRemaining = breakTime
            break
        case .longBreak:
            self.timeRemaining = longBreakTime
            break
        }
    }
    
    public func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
        self.timerState = .running
    }
    
    public func pauseTimer() {
        self.timerState = .paused
    }
    
    public func resumeTimer() {
        self.timerState = .running
    }
    
    @objc fileprivate func timerTick() {
        if (self.timerState == .running) {
            if (self.timeRemaining > 0) {
                self.timeRemaining -= 1
            } else {
                NSSound.beep()
            }
        }
    }

}
