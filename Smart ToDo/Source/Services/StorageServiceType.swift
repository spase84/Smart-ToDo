//
//  StorageServiceType.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import RxSwift

protocol StorageServiceType {
	var didReceiveUpdates: PublishSubject<[Task]> { get }
	func subscribeToFirebaseUpdates()
	func add(taskTitle: String)
	func update(task: Task)
	func fetchTasks()
}
