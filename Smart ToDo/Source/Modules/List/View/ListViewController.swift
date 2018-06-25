//
//  ListViewController.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
	private var notificationing: NotificationingType?
	private var presenter: ListPresenterType?
	private var items: [Task] = []
	private var filteredItems: [Task] = []
	private let taskCellID = "taskCell"
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
		setupTable()
		presenter?.viewIsReady()
	}
	
	// MARK: - private
	private func setupTable() {
		tableView.separatorStyle = .none
		tableView.allowsMultipleSelection = true
		tableView.register(UINib(nibName: "TaskCell", bundle: Bundle.main), forCellReuseIdentifier: taskCellID)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 150
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
		let alert = UIAlertController(title: NLS("add_task").firstUppercased, message: nil, preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.attributedPlaceholder = NSAttributedString(string: NLS("title").firstUppercased,
																													 attributes: [NSAttributedStringKey.foregroundColor: UIColor.mtSteel,
																																				NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15, weight: .light)])
		}
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] _ in
			guard let alertController = alert, let textField = alertController.textFields?.first else { return }
			if let title = textField.text,
				title.count > 0 {
				self?.presenter?.add(taskTitle: title)
			}
		}))
		alert.addAction(UIAlertAction(title: NLS("cancel").firstUppercased, style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	@objc private func hideKeyboard() {
		view.endEditing(true)
	}
}

extension ListViewController: ListViewType {

	func update(with list: [Task]) {
		items = list
		filteredItems = list
		tableView.reloadData()
	}
	
	func set(presenter: ListPresenterType) {
		self.presenter = presenter
	}

	func set(notificationing: NotificationingType) {
		self.notificationing = notificationing
	}

	func show(message: String, type: NotificationType) {
		notificationing?.show(message: message, type: type)
	}
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = filteredItems[indexPath.row]
		if let cell = tableView.dequeueReusableCell(withIdentifier: taskCellID, for: indexPath) as? TaskCell {
			cell.task = item
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let item = filteredItems[indexPath.row]
		if item.isDone {
			tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = filteredItems[indexPath.row]
		if let itemId = item.id {
			presenter?.set(isDone: true, taskId: itemId)
		}
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let item = filteredItems[indexPath.row]
		if let itemId = item.id {
			presenter?.set(isDone: false, taskId: itemId)
		}
	}
	
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		hideKeyboard()
	}
}

extension ListViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText.isEmpty {
			filteredItems = items
		} else {
			filteredItems = items.filter { ($0.title ?? "").lowercased().contains(searchText.lowercased()) }
		}
		tableView.reloadData()
	}
}
