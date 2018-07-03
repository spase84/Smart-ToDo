//
//  ListAssembly.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class ListAssembly: Assembly {
	func assemble(container: Container) {
		// register ViewModel
		container.register(ListViewModelType.self) { r in
			return ListViewModel(storage: r.resolve(StorageServiceType.self)!)
		}

		// initialization of ViewController
		container.storyboardInitCompleted(ListViewController.self) { (r, vc: ListViewType) in
			if let viewModel = r.resolve(ListViewModelType.self) as? ListViewModel {
				vc.set(viewModel: viewModel)
			}
			vc.set(notificationing: r.resolve(NotificationingType.self)!)
		}
	}
}
