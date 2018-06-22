//
//  ListPresenterType.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Foundation

protocol ListPresenterType {
	func viewIsReady()
	func viewWillAppear()
	func add(taskTitle: String)
	func set(isDone: Bool, taskId: String)
}
