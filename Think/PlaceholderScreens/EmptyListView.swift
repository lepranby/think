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
                Image(systemName: "book.pages.fill").resizable()
                    .foregroundStyle(scheme == .dark ? whiteColor : blackColor)
                    .frame(width: 120, height: 120)
                    .padding(.vertical)
                VStack (spacing: 2) {
                    Text("No any projects")
                    Text("added yet!")
                }.font(.title)
                HStack {
                    Text("Tap")
                    Image(systemName: "plus.circle").foregroundStyle(Color.accentColor)
                    Text("above to add new")
                }.font(.callout)
            }
        }
    }
}

#Preview {
    EmptyListView()
}
