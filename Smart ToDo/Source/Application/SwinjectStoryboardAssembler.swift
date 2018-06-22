//
//  SwinjectStoryboardAssembler.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import Swinject
import SwinjectStoryboard

private var assemblies: [Assembly] = [
	ServicesAssembly(),
	ListAssembly()
]

extension SwinjectStoryboard {
	@objc class func setup() {
		Assembler(container: SwinjectStoryboard.defaultContainer)
			.apply(assemblies: assemblies)
	}
}
