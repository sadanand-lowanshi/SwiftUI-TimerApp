//
//  Extension+Double.swift
//  TimerApp
//
//  Created by Sadanand on 26/10/23.
//

import Foundation

extension Double {
  
  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}
