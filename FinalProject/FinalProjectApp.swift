//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Owen Okst on 4/22/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FinalProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var postVM = PostViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(postVM)
        }
    }
}
