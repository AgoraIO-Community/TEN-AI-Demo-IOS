//
//  TranscriptionView.swift
//  TENDemo
//
//  Created by Rick Cheng on 8/21/24.
//
import SwiftUI

/// A struct representing a chat message with a unique identifier, speaker's name, and the message content.
struct ChatMessage: Identifiable {
    let id = UUID() // Unique identifier for each chat message
    let speaker: String // The name of the speaker
    let message: String // The content of the message
}

/// A view that displays a list of chat messages in a transcription format.
struct TranscriptionView: View {
    
    let messages: [ChatMessage] // Array of chat messages to display
    let speakerA: String // Name of the first speaker
    let speakerB: String // Name of the second speaker
    
    var body: some View {
        // Create a list to display each message
        List(messages) { message in
            HStack {
                // Check if the message is from speaker A
                if message.speaker == speakerA {
                    VStack(alignment: .leading) {
                        // Display speaker's name in a headline font and blue color
                        Text(message.speaker)
                            .font(.headline)
                            .foregroundColor(.blue)
                        // Display the message content in body font
                        Text(message.message)
                            .font(.body)
                            .foregroundColor(.primary) // Automatically adjusts to dark/light mode
                    }
                    Spacer() // Add space to the right
                }
                // Check if the message is from speaker B
                else if message.speaker == speakerB {
                    Spacer() // Add space to the left
                    VStack(alignment: .trailing) {
                        // Display speaker's name in a headline font and green color
                        Text(message.speaker)
                            .font(.headline)
                            .foregroundColor(.green)
                        // Display the message content in body font
                        Text(message.message)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
                // If the message is from an unknown speaker
                else {
                    Spacer() // Add space to the left
                    VStack(alignment: .trailing) {
                        // Display speaker's name in a headline font and purple color
                        Text(message.speaker)
                            .font(.headline)
                            .foregroundColor(.purple)
                        // Display the message content in body font
                        Text(message.message)
                            .font(.body)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.vertical, 4) // Add vertical padding to each message
        }
    }
}

/// A preview provider for the TranscriptionView to display sample data in the SwiftUI preview.
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        TranscriptionView(
            messages: [
                ChatMessage(speaker: "Alice", message: "Hello! How are you?"),
                ChatMessage(speaker: "Bob", message: "I'm good, thanks! How about you?"),
                ChatMessage(speaker: "Alice", message: "I'm doing well, thank you!"),
                ChatMessage(speaker: "Bob", message: "Want to go karaoke?"),
                ChatMessage(speaker: "Alice", message: "Why not?"),
                ChatMessage(speaker: "Alice", message: "Actually I want to eat"),
            ],
            speakerA: "Alice", // Set Alice as speaker A
            speakerB: "Bob"    // Set Bob as speaker B
        )
    }
}
