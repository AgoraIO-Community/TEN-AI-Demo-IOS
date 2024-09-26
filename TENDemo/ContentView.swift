//
//  ContentView.swift
//  TENDemo
//
//  Created by Rick Cheng on 8/8/24.
//

import SwiftUI

/// main display when opening the app with title, description, text input for a channel name and Join button.
/// 
struct ContentView: View {
    /// The user inputted `channelId` string.
    @State var channelId: String = AppConfig.shared.channel
    @State private var showingSettings = false
    @State private var isOn = AppConfig.shared.voiceType == .female
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    VStack {
                        Text("**TEN** AI Agent")
                            .padding()
                            .font(.largeTitle)
                        Text("The app is empowered by the technology of Realtime Communication, Realtime Transcription, a LLM and Text to Speech extensions. **TEN** stands for *Transformative Extensions Network*. You may ask the Agent for any general question.  Start the session by entering a channel name to join the chat.")
                            .frame(alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    
                    Spacer()
                    
                    VStack {
                        Text("Channel").font(.title2)
                        TextField("Enter text", text: $channelId)
                            .padding()
                            .border(Color.gray, width: 0.5)
                        NavigationLink(destination:
                                        ChatView(channelId: channelId)) {
                            Text("Join")
                                .padding(.horizontal,40)
                                .padding(.vertical,20)
                                .foregroundColor(.white)
                                .background(Color.cyan)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    HStack {
                        Text("Agent Voice:")
                        Text("Male")
                        Toggle("", isOn: $isOn)
                            .onChange(of: isOn) { newValue in
                                if (newValue) {
                                    AppConfig.shared.voiceType = .female
                                } else {
                                    AppConfig.shared.voiceType = .male
                                }
                            } .labelsHidden()
                        Text("Female")
                    }
                    Spacer()
                    .padding()
                    VStack {
                        HStack {
                            Text("Agora IO 2024")
                                .font(.caption)
                                .foregroundColor(.blue)
                            Text("version " + _appVersion)
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .onAppear {
                        self.channelId = getRandomChannel()
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(isPresented: $showingSettings)
            }
        }
    }
        
}

#Preview {
    ContentView()
}
