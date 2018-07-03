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

	public func subscribeToFirebaseUpdates() {
		checkFirebase()
		db?.collection("tasks").addSnapshotListener { [weak self] snapshot, error in
			guard let snapshot = snapshot else { return }
			let tasks = snapshot.documents.compactMap { doc -> Task? in
				var json = doc.data()
				json["id"] = doc.documentID
				return Task(json: json)
			}
			.sorted { t1, t2 in
				return t1.createdAt ?? Date() < t2.createdAt ?? Date()
			}
			self?.didReceiveUpdates.onNext(tasks)
		}
	}
	
	func add(taskTitle: String) {
		checkFirebase()
		var ref: DocumentReference?
		let json: [String: Any?] = ["id": nil,
		            "title": taskTitle,
		            "isDone": false,
		            "createdAt": Date().timeIntervalSince1970]
		ref = db?.collection("tasks").addDocument(data: json) { [weak self] err in
			self?.fetchTasks()
		}
	}
	
	func update(task: Task) {
		guard let taskId = task.id else { return }
		checkFirebase()
		db?.collection("tasks").document(taskId).setData(task.toJson())
	}

	func fetchTasks() {
		checkFirebase()

		self.db?.collection("tasks").getDocuments { [weak self] snapshot, error in
			if let err = error {
				self?.didReceiveUpdates.onError(err)
			} else {
				let tasks = snapshot?.documents.compactMap { doc -> Task? in
					var t = doc.data()
					t["id"] = doc.documentID
					return Task(json: t)
				}
				.sorted { t1, t2 in
					return t1.createdAt ?? Date() < t2.createdAt ?? Date()
				}
				self?.didReceiveUpdates.onNext(tasks ?? [])
			}
		}
	}

	// MARK: - private

	private func checkFirebase() {
		if nil == db {
			db = Firestore.firestore()
		}
	}
}
