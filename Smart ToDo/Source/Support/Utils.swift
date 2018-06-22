//
//  Utils.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Foundation

func NLS(_ key: String) -> String {
	return NSLocalizedString(key, comment: "")
}

func dp(_ items: Any...) {
	#if DEBUG
	var fullItems = items
	fullItems.append(Thread.current)
	debugPrint(fullItems, separator: ",")
	#endif
}
