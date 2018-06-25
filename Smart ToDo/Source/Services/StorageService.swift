//
//  StorageService.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import RxSwift
import Firebase
import FirebaseFirestore

class StorageService: StorageServiceType {
	private var db: Firestore?
	private(set) var didReceiveUpdates: PublishSubject<[Task]> = PublishSubject<[Task]>()
	private(set) var didSaveTask: PublishSubject<Task> = PublishSubject<Task>()

	public func subscribeToFirebaseUpdates() {
		checkFirebase()
		db?.collection("tasks").addSnapshotListener { [weak self] snapshot, error in
			guard let snapshot = snapshot else { return }
			let tasks = snapshot.documents.compactMap {
				return Task(json: $0.data())
			}
			self?.didReceiveUpdates.onNext(tasks)
		}
	}
	
	func add(task: Task) {
		checkFirebase()
		var ref: DocumentReference?
		ref = db?.collection("tasks").addDocument(data: task.toJson()) { [weak self] err in
			if let error = err {
				dp(error)
				self?.didSaveTask.onError(error)
			} else {
				var t = task
				t.id = ref?.documentID
				self?.didSaveTask.onNext(t)
			}
		}
	}
	
	func update(task: Task) {
		checkFirebase()

	}

	// MARK: - private

	private func checkFirebase() {
		if nil == db {
			db = Firestore.firestore()
		}
	}
}
