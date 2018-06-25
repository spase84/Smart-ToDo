//
// Created by Maksim Petrenko on 25.06.2018.
// Copyright (c) 2018 com.madteamlab. All rights reserved.
//

import UIKit

public extension UIApplication {

	/// Returns the status bar UIView
	var statusBarView: UIView? {
		return value(forKey: "statusBar") as? UIView
	}
}