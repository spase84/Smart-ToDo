//
//  ServicesAssembly.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Swinject

class ServicesAssembly: Assembly {
	func assemble(container: Container) {
		container.register(StorageServiceType.self) { _ in
			return StorageService()
		}.inObjectScope(.container) // singleton
		container.register(NotificationingType.self) { _ in
			return Notificationing()
		}
	}
}
