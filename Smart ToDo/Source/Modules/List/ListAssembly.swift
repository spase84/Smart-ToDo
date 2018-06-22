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
		// register presenter
		container.register(ListPresenterType.self) { (_, view: ListViewType) in
			return ListPresenter(with: view)
		}
		
		// initialization of ViewController
		container.storyboardInitCompleted(ListViewController.self) { (r, vc: ListViewType) in
			if let presenter = r.resolve(ListPresenterType.self, argument: vc) as? ListPresenter {
				
				vc.set(presenter: presenter)
			}
		}
	}
}
