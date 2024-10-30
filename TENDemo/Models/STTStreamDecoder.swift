//
//  STTStreamDecoder.swift
//  TENDemo
//
//  Created by Rick Cheng on 10/30/24.
//

import Foundation

///  Incoming stream is in Text Format
/// <id>|<index>|<total>|<content part>
///   sample: 0038dbd0|1|1|eyJpc19maW5hbCI6IHRydWUsICJzdHJlYW1faWQiOiAwLCAibWVzc2FnZV9pZCI6ICIwMDM4ZGJkMCIsICJkYXRhX3R5cGUiOiAidHJhbnNjcmliZSIsICJ0ZXh0X3RzIjogMTczMDMxOTcwNjIzMCwgInRleHQiOiAiVEVOIEFnZW50IGNvbm5lY3RlZC4gSG93IGNhbiBJIGhlbHAgeW91IHRvZGF5PyJ9
///
struct STTStreamMessage {
    let messageId: String
    let partIndex: Int
    let partsTotal: Int
    let content: String
    
    init(from input: String) {
        let components = input.split(separator: "|")
        self.messageId = String(components[0])
        self.partIndex = Int(components[1]) ?? 0
        self.partsTotal = Int(components[2]) ?? 0
        self.content = String(components[3])
    }
}

enum SttError : Error {
    case runtimeError(String)
}

///
///  A decoder takes the raw data from DataStrream and return the complete message.
///    If the message is too long to fit, there will be parts sent in separate event.  Assemble them
///    to form a valid base64 string for decoding.
class STTStreamDecoder {
    var contentBuffer : String = ""
    ///
    public func parseStream(data : Data) throws -> STTStreamText {
        if let str = String(data: data, encoding: .utf8) {
            let message = STTStreamMessage(from:str)
            contentBuffer = contentBuffer + message.content
            if (message.partIndex == message.partsTotal) {
                // this is the last piece of the base64 content
                if let jsonString = decodeBase64(contentBuffer) {
                    // clear the buffer
                    contentBuffer = ""
                    // string to data
                    if let jsonData = jsonString.data(using: .utf8) {
                        // decoded is the final result
                        do {
                            let stt = try JSONDecoder().decode(STTStreamText.self, from: jsonData)
                            return stt
                        } catch {}
                    }
                }
            }
        }
        throw SttError.runtimeError("streamed data format can't be parsed.")
    }
}
