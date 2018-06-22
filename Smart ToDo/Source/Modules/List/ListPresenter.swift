//
//  ListPresenter.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//
import RxSwift

class ListPresenter: ListPresenterType {
	weak var view: ListViewType?
	private var storage: StorageServiceType!
	private var disposeBag = DisposeBag()
	
	init(with view: ListViewType, storage: StorageServiceType) {
		self.view = view
		self.storage = storage
	}
	
	func viewIsReady() {
		storage.savedOnlineTriger.subscribe(onNext: { success in
			dp("SAVED")
		})
		.disposed(by: disposeBag)
	}
	
	func viewWillAppear() {
		view?.update(with: storage.getList())
	}
	
	func add(taskTitle: String) {
		let task = Task(id: nil, title: taskTitle, isDone: false, createdAt: nil)
		storage.save(task: task)
	}

	func set(isDone: Bool, taskId: String) {
		dp(taskId, isDone)
	}
}
