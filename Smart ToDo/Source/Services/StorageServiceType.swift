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
	var didSaveTask: PublishSubject<Task> { get }
	func subscribeToFirebaseUpdates()
	func add(task: Task)
	func update(task: Task)
}
