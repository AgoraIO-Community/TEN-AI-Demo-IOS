//
//  SettingsView.swift
//  TENDemo
//
//  Created by Rick Cheng on 9/16/24.
//

import SwiftUI

struct Settings {
    static var shared : Settings = Settings()
    var cameraOn : Bool = true
}

/// The view provides user with options and info to use this App
struct SettingsView: View {
    @Binding var isPresented: Bool
    
    @State var VoiceType : String = "Male Voice"
    @State var cameraOn: Bool = Settings.shared.cameraOn
    @State var voiceOption = AppConfig.shared.voiceType == .male  // true = male, false = female

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Agent")) {
                    Toggle(VoiceType, isOn: $voiceOption)
                    .onChange(of: voiceOption) { newValue in
                        if newValue {
                            AppConfig.shared.voiceType = .male
                        } else {
                            AppConfig.shared.voiceType = .female
                        }
                        VoiceType = voiceOption ? "Male Voice" : "Female Voice"
                    }
                }
                Section(header: Text("RTC")) {
                    Toggle("Camera", isOn: $cameraOn)
                        .onChange(of: cameraOn) { newValue in
                            Settings.shared.cameraOn = newValue
                        }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                // Dismiss the sheet
                isPresented = false
            })
        }
    }
}

