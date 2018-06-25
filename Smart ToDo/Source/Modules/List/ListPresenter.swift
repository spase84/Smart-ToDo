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
		storage.subscribeToFirebaseUpdates()

		storage.didReceiveUpdates.subscribe(onNext: { [weak self] tasks in
			self?.view?.update(with: tasks)
		}, onError: { error in
			dp(error.localizedDescription)
		})
		.disposed(by: disposeBag)

		storage.didSaveTask.subscribe(onNext: { [weak self] task in
			self?.view?.show(message: NLS("save_success"), type: .success)
		}, onError: { [weak self] error in
			self?.view?.show(message: NLS("save_error"), type: .error)
		})
		.disposed(by: disposeBag)
	}
	
	func add(taskTitle: String) {
		let task = Task(json: ["id": nil,
		                 "title": taskTitle,
		                 "isDone": false,
		                 "createdAt": Date().timeIntervalSince1970])
		storage.add(task: task)
	}

	func set(isDone: Bool, taskId: String) {
		dp(taskId, isDone)
	}
}
