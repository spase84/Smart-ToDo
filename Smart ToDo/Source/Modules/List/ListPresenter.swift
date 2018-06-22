//
//  ListPresenter.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Foundation

class ListPresenter: ListPresenterType {
	weak var view: ListViewType?
	
	init(with view: ListViewType) {
		self.view = view
	}
	
	func viewWillAppear() {
		dp("PRESENTER: viewWillAppear")
	}
	
	func add(task: Task) {
		
	}
}
