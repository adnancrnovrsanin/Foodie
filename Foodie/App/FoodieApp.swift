//
//  FoodieApp.swift
//  Foodie
//
//  Created by Muhedin Alic on 06.08.24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    public var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct FoodieApp: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var locationManager = LocationManager.shared

    var body: some Scene {
        WindowGroup {
            HomeViewWrapper()
                .environmentObject(AuthViewModel())        // Passing AuthViewModel as an environment object
                .environmentObject(HomeViewModel())        // Passing HomeViewModel as an environment object
        }
    }
}

