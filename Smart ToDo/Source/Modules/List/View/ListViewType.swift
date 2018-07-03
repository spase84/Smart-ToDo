//
//  ListViewType.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Foundation

protocol ListViewType: class {
	func set(viewModel: ListViewModelType)
	func set(notificationing: NotificationingType)
	func show(message: String, type: NotificationType)
}
