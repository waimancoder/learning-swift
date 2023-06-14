//
//  CryptomanicApp.swift
//  Cryptomanic
//
//  Created by Fakhruddin Aiman on 14/06/2023.
//

import SwiftUI

@main
struct CryptomanicApp: App {
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }.environmentObject(vm)
            
        }
    }
}
