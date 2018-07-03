//
// Created by Maksim Petrenko on 25.06.2018.
// Copyright (c) 2018 com.madteamlab. All rights reserved.
//

import UIKit

public enum NotificationType {
	case error, info, success
}

public class Notificationing: NotificationingType {
	private let timeout: Int = 4
	private let view: UIView = UIView()
	private var timer: Timer?
	public func show(message: String, type: NotificationType) {
		self.hide(force: true)
		self.addView(message: message, type: type)
		self.show()
	}

	// MARK: - private

	private func addView(message: String, type: NotificationType) {
		view.alpha = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 8
		view.clipsToBounds = true
		switch type {
		case .info:
			self.view.backgroundColor = UIColor.mtAzure
		case .error:
			self.view.backgroundColor = UIColor.mtTomato
		case .success:
			self.view.backgroundColor = UIColor(red: 2/255, green: 184/255, blue: 33/255, alpha: 1)
		}
		let label = UILabel()
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.2
		label.translatesAutoresizingMaskIntoConstraints = false
		label.attributedText = NSAttributedString(string: message, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17,
				weight: .light),
			NSAttributedStringKey.foregroundColor: UIColor.white])
		self.view.addSubview(label)
		var constraints = [NSLayoutConstraint]()
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[lbl]-16-|", options: [],
				metrics: nil, views: ["lbl": label])
		constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[lbl]-16-|", options: [],
				metrics: nil, views: ["lbl": label])
		if let rootView = self.getRootView() {
			rootView.addSubview(self.view)

			constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[view]-8-|", options: [],
					metrics: nil, views: ["view": view])
			constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-6-[view]", options: [],
					metrics: nil, views: ["view": view])
		}

		NSLayoutConstraint.activate(constraints)
	}

	private func getRootView() -> UIView? {
		return UIApplication.shared.statusBarView
	}

	private func show() {

		UIView.animate(withDuration: 0.4, animations: {
			self.view.alpha = 1
		}, completion: { completed in
			if completed {
				self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(self.timeout), repeats: false, block: { (timer) in
					self.hide()
					timer.invalidate()
				})
			}
		})
	}

	@objc private func hide(force: Bool = false) {
		if force {
			self.view.alpha = 0
			self.clean()
			self.timer?.invalidate()
			self.timer = nil
		} else {
			UIView.animate(withDuration: 0.4, animations: {
				self.view.alpha = 0
			}, completion: { completed in
				if completed {
					self.clean()
					self.timer?.invalidate()
					self.timer = nil
				}
			})
		}
	}

	private func clean() {
		for sv in self.view.subviews {
			sv.removeFromSuperview()
		}
		self.view.removeFromSuperview()
	}
}
