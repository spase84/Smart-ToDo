//
//  StorageService.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import RxSwift

class StorageService: StorageServiceType {
	
	private(set) var savedOnlineTriger: PublishSubject<Bool> = PublishSubject<Bool>()
	
	public func getList() -> [Task] {
//		let list = [Task]()
		let list = [
			Task(id: "some ID",
					title: "Заправить машину",
					isDone: false,
					createdAt: Date().addingTimeInterval(TimeInterval(3600) * (-1))),
			Task(id: "some other ID",
					 title: "Купить напрявляющие в Леруа",
					 isDone: true,
					 createdAt: Date().addingTimeInterval(TimeInterval(3600) * (-1)))
		]
		
		return list
	}
	
	func save(task: Task) {
		dp(task)
		
		savedOnlineTriger.onNext(true)
	}
	
	func remove(task: Task) {
		
	}
}
