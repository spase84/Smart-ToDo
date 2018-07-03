//
//  AppDelegate.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		// Firebase
		FirebaseApp.configure()

		// Defaults for UINavigationBar
		UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white,
																												NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17, weight: .light)]
		UINavigationBar.appearance().barTintColor = UIColor.mtBlackTwo
		UINavigationBar.appearance().tintColor = UIColor.white
		// Defaults for UISearchBar
		UISearchBar.appearance().barTintColor = UIColor.mtBlackTwo
		UISearchBar.appearance().backgroundColor = UIColor.mtBlackTwo

		return true
	}
}

