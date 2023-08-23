//
//  one_grain_dailyApp.swift
//  one-grain-daily
//
//  Created by 김주현 on 2023/08/18.
//

import SwiftUI

	@main
struct one_grain_dailyApp: App {
    @StateObject var userModel = UserModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(userModel)
        }
    }
}

