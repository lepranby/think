//  Haptic.swift
//  Think
//
//  Created by Aleksej Shapran on 24.04.24

import Foundation
import SwiftUI

func hapticSoft () {

    let hapticAction = UIImpactFeedbackGenerator(style: .soft)
        hapticAction.impactOccurred()

}

func hapticMedium () {

    let hapticAction = UIImpactFeedbackGenerator(style: .medium)
        hapticAction.impactOccurred()

}
