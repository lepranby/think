//  EmptyTeamsView.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import SwiftUI

struct EmptyTeamsView: View {

    @Environment(\.colorScheme) var scheme

    let blackColor = Color.accentColor.gradient
    let whiteColor = Color.gray.gradient

    var body: some View {
        ZStack {
            VStack (spacing: 12) {
                Image(systemName: "person.slash").resizable()
                    .foregroundStyle(scheme == .dark ? whiteColor : blackColor)
                    .frame(width: 120, height: 120)
                    .padding(.vertical)
                VStack (spacing: 2) {
                    Text("No any people")
                    Text("added yet!")
                }.font(.title)
                HStack {
                    Text("Tap")
                    Image(systemName: "person.crop.circle.badge.plus").foregroundStyle(Color.accentColor)
                    Text("above to add new")
                }.font(.callout)
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    EmptyTeamsView()
}
