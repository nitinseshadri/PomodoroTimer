//
//  ContentView.swift
//  FriendlyNeighborhoodPomodoro
//
//  Created by Nitin Seshadri on 4/9/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerModel: PomodoroTimerModel
    
    @State var timerMode: PomodoroTimerModel.PomodoroTimerMode = .pomodoro
    
    var body: some View {
        VStack {
            VStack {
                Text("\(DateComponentsFormatter().string(from:TimeInterval(timerModel.timeRemaining))!)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(timerModel.timeRemaining > 0 ? Color.black : Color.red)
                            .opacity(0.75)
                    )
                HStack {
                    Button(timerModel.timerState == .running ? "Pause" : "Start") {
                        switch (timerModel.timerState) {
                        case .reset:
                            timerModel.startTimer()
                            break
                        case .running:
                            timerModel.pauseTimer()
                            break
                        case .paused:
                            timerModel.resumeTimer()
                            break
                        }
                    }
                    .disabled(!(timerModel.timeRemaining > 0))
                    Button("Reset") {
                        timerModel.resetTimer(mode: self.timerMode)
                    }
                }
            }
            GroupBox {
                Picker(selection: self.$timerMode, label: Text("Mode:")) {
                    Text("Pomodoro").tag(PomodoroTimerModel.PomodoroTimerMode.pomodoro)
                    Text("Break").tag(PomodoroTimerModel.PomodoroTimerMode.scheduledBreak)
                    Text("Long Break").tag(PomodoroTimerModel.PomodoroTimerMode.longBreak)
                }
                .pickerStyle(RadioGroupPickerStyle())
                .onChange(of: self.timerMode) { newValue in
                    timerModel.resetTimer(mode: newValue)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
