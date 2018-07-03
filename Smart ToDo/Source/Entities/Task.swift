//
//  Task.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Foundation

struct Task {
	var id: String?
	var title: String?
	var isDone: Bool = false
	var createdAt: Date?

	init(json: [String: Any?]) {
		id = json["id"] as? String
		title = json["title"] as? String
		isDone = (json["isDone"] as? Bool) ?? false
		createdAt = json["createdAt"] as? Date
	}

	func toJson() -> [String: Any] {
		return [
			"id": id,
			"title": title,
			"isDone": isDone,
			"createdAt": createdAt ?? Date()
		]
	}

}
