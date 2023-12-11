//
//  ProgressBarView.swift
//  TimerApp
//
//  Created by Sadanand on 26/10/23.
//

import SwiftUI

struct ProgressBarView: View {
  
  @Binding var progress: TimeInterval // Current progress of timer
  @Binding var goal: Double // Total goal time
  
  var body: some View {
    
    ZStack {
      // Default circle
      Circle()
        .stroke(
          style: StrokeStyle(
            lineWidth: 20,
            lineCap: .butt,
            dash: [2, 6])
        )
        .fill(Color.gray)
        .rotationEffect(Angle(degrees: -90))
        .frame(
          width: 300,
          height: 300
        )
      
      // overlap circle
      Circle()
        .trim(
          from: 0,
          to: CGFloat(progress) / CGFloat(goal)
        )
        .stroke(
          style: StrokeStyle(
            lineWidth: 20,
            lineCap: .butt,
            dash: [2, 6])
        )
        .fill(
          Color(
            red: 236/255, green: 230/255, blue: 0/255
          )
        )
        .animation(
          .spring(),
          value: progress
        )
        .rotationEffect(Angle(degrees: -90))
        .frame(
          width: 300,
          height: 300
        )
    }
  }
}

struct ProgressBarView_Previews: PreviewProvider {
  
  static var previews: some View {
    ProgressBarView(
      progress: .constant(0),
      goal: .constant(0)
    )
  }
}
