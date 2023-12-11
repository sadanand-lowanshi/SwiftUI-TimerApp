//
//  ContentView.swift
//  TimerApp
//
//  Created by Sadanand on 25/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var timerVM: TimerViewModel // Manage timer model
    @State var isPaused = false // Manage pause or start
    @State private var rotation = 0
    
    init(seconds: TimeInterval = 0) {
        timerVM = TimerViewModel(
            seconds: seconds,
            goalTime: 20
        )
    }
    
    var body: some View {
        ZStack {
            // MARK: - Background color
            Color(
                red: 63/255, green: 68/255, blue: 3/255
            )
            .ignoresSafeArea() // End background color
            
            // MARK: - Progress Bar ring
            ProgressBarView(
                progress: $timerVM.seconds,
                goal: $timerVM.goalTime
            ) // End Progress Bar ring
            
            // MARK: - Center title
            VStack {
                // Center title
                Text(timerVM.progress >= 1 ? "Done" : timerVM.displayTime)
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                // Center sub title
                Text("\(timerVM.goalTime.asString(style: .short))")
                    .foregroundColor(.white.opacity(0.6))
            } // End Center title
            
            // MARK: - Bottom Buttons
            VStack {
                Text("Timer App Demo")
                    .font(.title)
                    .foregroundColor(
                        Color(
                            red: 180/255, green: 187/255, blue: 62/255
                        )
                    )
                Spacer()
                ButtonView()
            } // End Bottom Buttons
            .onAppear {
                timerVM.startSession()
                timerVM.viewDidLoad()
            }
        }
    }
}

extension ContentView {
    
    private func ButtonView() -> some View {
        
        HStack {
            // Reset Button
            Button {
                reset()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.clockwise")
                        .rotationEffect(.degrees(Double(rotation)))
                    Text("Reset")
                } .padding()
                    .tint(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18, weight: .bold))
            }
            .background(
                Color(
                    red: 236/255, green: 230/255, blue: 0/255)
            )
            .cornerRadius(15) // End
            
            // Start & pause Button
            Button {
                if timerVM.progress < 1 {
                    isPaused.toggle()
                    isPaused ? timerVM.pauseSession() :  timerVM.startSession()
                }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: isPaused ? "play.fill" : "pause.fill")
                    Text(isPaused ? "Start" : "Pause")
                } .padding()
                    .tint(.black)
                    .frame(maxWidth: .infinity)
                    .font(.system(
                        size: 18,
                        weight: .bold)
                    )
            }
            .background(
                Color(
                    red: 236/255, green: 230/255, blue: 0/255)
            )
            .cornerRadius(15)
        }.padding(.bottom, 40)
            .padding([.leading, .trailing], 20) // End Start & pause Button
    }
    
    private func reset() {
        withAnimation(.easeInOut(duration: 0.4)) {
            rotation += 360
        }
        if timerVM.progress >= 1 {
            timerVM.reset()
            timerVM.startSession()
        } else {
            timerVM.reset()
            timerVM.displayTime = "00:00"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






