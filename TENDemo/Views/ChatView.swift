//
//  ChatView.swift
//  TENDemo
//
//  Created by Rick Cheng on 8/9/24.
//

import SwiftUI

/// A view that displays the video feed for all the users who join the channel for chat.
/// If the user is not publishing the video feed (e.g. camera is not enabled), then a placeholder view
/// will be shown in place.
struct ChatView: View {
    @State var _preview = false
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(channelId: String) {
        AppConfig.shared.channel = channelId
        if (channelId == "preview") {
            _preview = true
        }
    }
    
    /// Agora Manager holdes the user information that are leverage to show in a view
    @ObservedObject public var agoraManager = AgoraManager(appId: AppConfig.shared.appId, role: .broadcaster)

    public var body: some View {
        VStack {
            // Title with channel info
            HStack {
                Text("Channel:").foregroundColor(.black).font(.title)
                Text(AppConfig.shared.channel).foregroundColor(.blue).font(.title)
            }.padding(20)
            
            // structuring a 2 columns/multi-row grid view
            let columns = Array(repeating: GridItem(.flexible()), count: 2)
            LazyVGrid(columns: columns, spacing: 20) {
                    // Show the video feeds for each participant.
                    ForEach(Array(agoraManager.allUsers), id: \.self) { uid in
                        Group {
                            if let pub = agoraManager.userVideoPublishing[uid] {
                                if (pub) {
                                    // this is a component that show streaming video feeds
                                    AgoraVideoCanvasView(manager: agoraManager, uid: uid)
                                        .aspectRatio(contentMode: .fit).cornerRadius(10)
                                } else {
                                    // a placeholder; it will show the uid as the distinguisher
                                    PlaceHolderUserView(user: uid).aspectRatio(contentMode: .fit).cornerRadius(10)
                                }
                            } else {
                                // Placeholder
                                if (uid == AppConfig.shared.agentUid) {
                                    SoundVisualizer(agora: agoraManager)
                                } else {
                                    PlaceHolderUserView(user: uid).aspectRatio(contentMode: .fit).cornerRadius(10)
                                }
                            }
                        }
                    }
            }//.padding(20)
            
            // The transcription of the Agent and local user
            TranscriptionView(
                messages: agoraManager.messages,
                    speakerA: "Agent",
                    speakerB: "You"
            ).scaledToFit()
            ToastView(message: $agoraManager.label)
            .onReceive(timer) { time in
                if (!_preview) {
                    // A Ping message is required to keep the connection alive
                    agoraManager.pingSession()
                }
            }
        }.onAppear { // Note this onAppear is an async extension
            if (!_preview) {
                // This step sets up a session with server extensions
                // Server will bring up RTC and other associated agents
                await agoraManager.startSession(withAI: true)
            }
        }.onDisappear {
            timer.upstream.connect().cancel()
            if (!_preview) {
                agoraManager.stopSession()
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
           
    }
}

#Preview {
   ChatView(channelId: "preview")
}
