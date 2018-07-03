//
// Created by Maksim Petrenko on 29.06.2018.
// Copyright (c) 2018 com.madteamlab. All rights reserved.
//

import Foundation
import RxSwift

protocol ListViewModelType {
	var tasks: BehaviorSubject<[Task]> { get }
	var search: PublishSubject<String> { get }
	var didSelect: PublishSubject<Task> { get }
	func add(taskTitle: String)
	func viewIsReady()
	func update(task: Task)
}

class ListViewModel: ListViewModelType {

	private let disposeBag = DisposeBag()
	private var storage: StorageServiceType!
	private(set) var tasks = BehaviorSubject<[Task]>(value: [])
	private(set) var search = PublishSubject<String>()
	private(set) var didSelect = PublishSubject<Task>()
	private var taskList: [Task] = []


	init(storage: StorageServiceType) {
		self.storage = storage
	}

	func viewIsReady() {
		fetchTasksAndUpdateObservableTasks()
		subscribeSearchAndUpdateObservableTasks()
		subscribeToSelection()
	}

	func update(task: Task) {
		storage.update(task: task)
	}

	func add(taskTitle: String) {
		storage.add(taskTitle: taskTitle)
	}

	// MARK: - private
	private func fetchTasksAndUpdateObservableTasks() {
		storage.didReceiveUpdates
			.subscribe(onNext: { tasks in
				self.taskList = tasks
				self.tasks.onNext(tasks)
			}, onError: { err in
				dp(err.localizedDescription)
			})
			.disposed(by: disposeBag)

		storage.fetchTasks()
	}

	private func subscribeSearchAndUpdateObservableTasks() {
		search.subscribe(onNext: { searchText in
			if searchText.count > 0 {
				let filtered = self.taskList.filter {
					($0.title ?? "").lowercased().contains(searchText.lowercased())
				}
				self.tasks.onNext(filtered)
			} else {
				self.tasks.onNext(self.taskList)
			}
		})
		.disposed(by: disposeBag)
	}

	private func subscribeToSelection() {
		didSelect.subscribe(onNext: { task in
			self.storage.update(task: task)
		})
		.disposed(by: disposeBag)
	}
}