//
//  StringExtension.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Foundation

public extension String {
	var firstUppercased: String {
		guard let first = first else { return "" }
		return String(first).uppercased() + dropFirst()
	}
}
