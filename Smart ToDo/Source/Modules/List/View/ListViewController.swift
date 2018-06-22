//
//  ListViewController.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
	private var presenter: ListPresenterType?
	private var items: [Task] = []
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
		setupTable()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
	
	// MARK: - private
	private func setupTable() {
		tableView.separatorStyle = .none
	}
	
	private func setupNavBar() {
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
			navigationItem.largeTitleDisplayMode = .always
		}
		navigationItem.title = NLS("todos").firstUppercased
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icAdd").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
																														 style: .plain,
																														 target: self,
																														 action: #selector(addAction))
		navigationController?.navigationBar.shadowImage = UIImage(color: UIColor.mtBlackTwo)
	}
	
	@objc private func addAction() {
		dp("add action event")
	}
}

extension ListViewController: ListViewType {
	func update(with list: [Task]) {
		items = list
		tableView.reloadData()
	}
	
	func set(presenter: ListPresenterType) {
		self.presenter = presenter
	}
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		// configure cell here
		let item = items[indexPath.row]
		cell.textLabel?.text = item.title
	}
}

extension ListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		debugPrint(searchText)
	}
}
