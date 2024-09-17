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
    
    func getVoiceName(voiceType: VoiceType ) -> String {
        switch(voiceType) {
        case .male:
            return "en-US-BrianNeural"
        case .female:
            return "en-US-JaneNeural"
        }
    }
}

/// The view provides user with options and info to use this App
struct SettingsView: View {
    @Binding var isPresented: Bool
    
    @State var voiceTypeLabel : String = AppConfig.shared.voiceType.description.capitalized + " Voice"
    @State var cameraOn: Bool = Settings.shared.cameraOn
    @State var voiceOption = AppConfig.shared.voiceType == .male  // true = male, false = female

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Agent")) {
                    Toggle(voiceTypeLabel, isOn: $voiceOption)
                    .onChange(of: voiceOption) { newValue in
                        if newValue {
                            AppConfig.shared.voiceType = .male
                        } else {
                            AppConfig.shared.voiceType = .female
                        }
                        voiceTypeLabel = getVoiceType()
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
    
    func getVoiceType() -> String {
        return AppConfig.shared.voiceType.description.capitalized + " Voice"
    }
}

