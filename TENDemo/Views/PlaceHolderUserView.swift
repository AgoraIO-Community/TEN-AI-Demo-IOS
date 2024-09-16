//
//  PlaceHolderUserView.swift
//  TENDemo
//
//  Created by Rick Cheng on 8/9/24.
//

import SwiftUI

let PlaceHolderIcon = "agora-icon-logo"

/// A view that shows an icon and the UID
///
struct PlaceHolderUserView: View {
    let uid: UInt
    
    init(user: UInt) {
       uid = user
    }
    var body: some View {
        ZStack(alignment: .center) {
            Image(PlaceHolderIcon).resizable().aspectRatio(contentMode: .fit)
            VStack {
                Text("UID" + String(uid))
                    .font(.callout)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    PlaceHolderUserView(user: 1234)
}
