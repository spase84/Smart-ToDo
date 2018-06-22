//
//  StorageServiceType.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import RxSwift

protocol StorageServiceType {
	var savedOnlineTriger: PublishSubject<Bool> { get }
	func getList() -> [Task]
	func save(task: Task)
	func remove(task: Task)
}
