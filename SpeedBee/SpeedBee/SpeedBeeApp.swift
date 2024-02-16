//
//  SpeedBeeApp.swift
//  SpeedBee
//
//  Created by Cole Abrams on 2/14/24.
//

import SwiftUI

@main
struct SpeedBeeApp: App {
    @StateObject var speedBeeDataModel = SpeedBeeDataModel()

    var body: some Scene {
        WindowGroup {
            NavView()
                .environmentObject(speedBeeDataModel)
        }
    }
}
