//  EmptyListView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI

struct EmptyListView: View {

    @Environment(\.colorScheme) var scheme

    let blackColor = Color.accentColor.gradient
    let whiteColor = Color.gray.gradient

    var body: some View {

        ZStack {
            VStack (spacing: 12) {
                Image(systemName: "number").resizable()
                    .foregroundStyle(scheme == .dark ? whiteColor : blackColor)
                    .frame(width: 120, height: 120)
                    .padding(.vertical)
                Text("No any projects added!")
                    .font(.title2)
                HStack {
                    Text("Tap")
                    Image(systemName: "bag.badge.plus").foregroundStyle(Color.accentColor)
                    Text("to add new")
                }.font(.title3)
            }
        }
    }
}

#Preview {
    EmptyListView()
}
