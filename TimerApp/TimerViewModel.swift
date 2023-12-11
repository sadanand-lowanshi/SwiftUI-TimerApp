//
//  TimerViewModel.swift
//  TimerApp
//
//  Created by Sadanand on 25/10/23.
//

import SwiftUI
import AudioToolbox
import AVFoundation

class TimerViewModel: NSObject, ObservableObject {
  
  @Published var progress: Double
  @Published var seconds: TimeInterval
  @Published var displayTime: String = ""
  @Published var goalTime: Double = 0 // Default 0
  
  private var timer: Timer = Timer()
  private var SoundID: SystemSoundID = 1407 // A system sound object, identified with a sound file you want to play.
  private let feedback = UIImpactFeedbackGenerator(style: .soft) // A concrete feedback generator subclass that creates haptics to simulate physical impacts.
  
  init(seconds: TimeInterval, goalTime: Double) {
    self.seconds = seconds
    self.goalTime = goalTime
    self.progress = seconds / Double(goalTime)
  }
  
  @objc func fireTimer() {
    seconds += 0.2
    progress = Double(seconds) / Double(goalTime)
    self.displayTime = calculateDisplayTime()
    print(progress)
    
    // Timer is completed
    if progress >= 1 {
      stopSession()
      makeSoundAndVibration() // Play sound when time is completed
    }
  }
  
  func startSession() {
    print("Timer started")
    timer = Timer.scheduledTimer(
      timeInterval: 0.2,
      target: self,
      selector: #selector(self.fireTimer),
      userInfo: nil,
      repeats: true
    )
  }
  
  func stopSession() {
    print("Timer Stoped")
    timer.invalidate()
  }
  
  func pauseSession() {
    timer.invalidate()
  }
  
  func reset() {
    seconds = 0
    progress = 0
  }
}

// MARK: - Public Methods
extension TimerViewModel {
  
  func viewDidLoad() {
    self.progress = seconds / Double(goalTime)
    self.displayTime = calculateDisplayTime()
  }
}

extension TimerViewModel {
  
  private func calculateDisplayTime() -> String {
    var time = ""
    let minutes = Int(seconds) / 60
    let seconds = Int(seconds) % 60
    
    if minutes > 9 {
      time.append(minutes.description)
    } else {
      time.append("0" + minutes.description)
    }
    
    time.append(":")
    
    if seconds > 9 {
      time.append(seconds.description)
    } else {
      time.append("0" + seconds.description)
    }
    
    return time
  }
}

extension TimerViewModel {
  
  private func makeSoundAndVibration() {
    AudioServicesPlayAlertSoundWithCompletion(SoundID, nil)
    AudioServicesPlayAlertSoundWithCompletion(
      SystemSoundID(kSystemSoundID_Vibrate)
    ) {
    }
  }
}
