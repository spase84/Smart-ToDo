//
//  ListViewController.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
	private var notificationing: NotificationingType?
	private var viewModel: ListViewModelType?
	private let taskCellID = "taskCell"
	private let disposeBag = DisposeBag()
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavBar()
		viewModel?.viewIsReady()
		setupTable()
	}
	
	// MARK: - private
	private func setupTable() {
		tableView.separatorStyle = .none
		tableView.allowsMultipleSelection = true
		tableView.register(UINib(nibName: "TaskCell", bundle: Bundle.main), forCellReuseIdentifier: taskCellID)
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 150

		viewModel?.tasks.asObservable()
		.bind(to: tableView.rx.items(cellIdentifier: taskCellID, cellType: TaskCell.self)) {
			[weak self] (row, element, cell) in
			cell.task = element
			if element.isDone {
				self?.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .none)
			}
		}
		.disposed(by: disposeBag)

		tableView.rx.modelSelected(Task.self).subscribe(onNext: { [weak self] task in
			var t = task
			t.isDone = true
			self?.viewModel?.didSelect.onNext(t)
		})
		.disposed(by: disposeBag)

		tableView.rx.modelDeselected(Task.self)
		.subscribe(onNext: { [weak self] task in
			var t = task
			t.isDone = false
			self?.viewModel?.didSelect.onNext(t)
		})
		.disposed(by: disposeBag)

		tableView.rx.setDelegate(self).disposed(by: disposeBag)

		searchBar.rx.text.subscribe(onNext: { [weak self] searchText in
			self?.viewModel?.search.onNext(searchText ?? "")
		})
		.disposed(by: disposeBag)
	}
	
	private func setupNavBar() {
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
			navigationItem.largeTitleDisplayMode = .always
		}
		navigationItem.title = NLS("todos").firstUppercased
		navigationController?.setNavigationBarHidden(false, animated: true)
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icAdd")
				.withRenderingMode(UIImageRenderingMode.alwaysTemplate),
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
			textField.autocapitalizationType = .sentences
		}
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert, weak self] _ in
			guard let alertController = alert, let textField = alertController.textFields?.first else { return }
			if let title = textField.text,
				title.count > 0 {
				self?.viewModel?.add(taskTitle: title)
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
	func set(viewModel: ListViewModelType) {
		self.viewModel = viewModel
	}

	func set(notificationing: NotificationingType) {
		self.notificationing = notificationing
	}

	func show(message: String, type: NotificationType) {
		notificationing?.show(message: message, type: type)
	}
}

extension ListViewController: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		hideKeyboard()
	}
}
