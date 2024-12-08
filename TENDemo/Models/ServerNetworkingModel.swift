//
//  ServerNetworkingModel.swift
//  TENDemo
//
//  Created by Rick Cheng on 8/14/24.
//

import Foundation

/// ==========================================================
/// MARK : Request Models
///

/// Represents a request for an Agora RTC token.
struct AgoraRTCTokenRequest : Codable {
    /// The unique identifier for the request.
    var requestId: String
    /// The name of the Agora channel.
    var channelName: String
    /// The user ID.
    var uid : UInt
    
    /// Coding keys for the request.
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
        case uid
    }
}

/// Represents the properties for starting a service.
struct ServerStartProperties : Codable {
    /// Properties for Agora RTC.
    let agoraRtc : [String:String]
    /// Properties for OpenAI ChatGPT.
    let openaiChatGPT : [String:String]
    /// Properties for Azure TTS.
    let azureTTS : [String:String]
    /// Coding keys for the properties.
    enum CodingKeys: String, CodingKey {
        case agoraRtc = "agora_rtc"
        case openaiChatGPT = "openai_chatgpt"
        case azureTTS = "azure_tts"
    }
}

/// Represents a request to start a service.
struct ServiceStartRequest: Codable {
    /// The unique identifier for the request.
    let requestId: String
    /// The name of the Agora channel.
    let channelName: String
    /// The remote stream ID.
    let userUID: UInt
    /// The name of the graph.
    let graphName: String
    /// The spoken language
    let language: String
    /// The type of voice.
    let voiceType: String
    /// The properties for starting the service.
    let properties: ServerStartProperties

    /// Coding keys for the request.
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
        case userUID = "user_uid"
        case graphName = "graph_name"
        case voiceType = "voice_type"
        case properties = "properties"
        case language
    }
}

/// Represents a request to stop a service.
struct ServiceStopRequest : Codable {
    /// The unique identifier for the request.
    let requestId: String
    /// The name of the Agora channel.
    let channelName: String
    
    /// Coding keys for the request.
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
    }
}

/// Represents a request to ping a service.
struct ServicePingRequest : Codable {
    /// The unique identifier for the request.
    let requestId: String
    /// The name of the Agora channel.
    let channelName: String
    
    /// Coding keys for the request.
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case channelName = "channel_name"
    }
}

/// ==========================================================
/// MARK : Response Models
///

/// A Codable struct representing the token server response.
struct AgoraRTCTokenResponse: Codable {
    /// The response code.
    let code: String
    /// The token data.
    let data: TokenDataClass
    /// The response message.
    let msg: String
}

/// A Codable struct representing the server response for commands like start,stop and ping
struct AgoraServerCommandResponse: Codable {
    /// The response code. "0" for success, error code otherwise.
    let code: String
    /// Non-zero if there is an error.
    let data: Int
    /// Explains what went wrong if error occurs.
    let msg: String
}

/// A Codable struct representing the token data.
struct TokenDataClass: Codable {
    /// The app ID.
    let appId: String
    /// The channel name.
    let channelName: String
    /// The token.
    let token: String
    /// The user ID.
    let uid: UInt

    /// Coding keys for the token data.
    enum CodingKeys: String, CodingKey {
        case appId
        case channelName = "channel_name"
        case token
        case uid
    }
}

/// A Codable struct representing the text data from an STT stream.
struct STTStreamText: Codable {
    /// The text from the stream.
    let text: String
    /// Indicates whether the text is final.
    let isFinal: Bool
    /// The stream ID.
    let streamID: Int
    /// The data type.
    let dataType: String
    /// The timestamp of the text.
    let textTS: Int64

    /// Coding keys for the STT stream text.
    enum CodingKeys: String, CodingKey {
        case text
        case isFinal = "is_final"
        case streamID = "stream_id"
        case dataType = "data_type"
        case textTS = "text_ts"
    }
}

