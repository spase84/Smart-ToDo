//
//  TaskCell.swift
//  Smart ToDo
//
//  Created by Maksim Petrenko on 22.06.2018.
//  Copyright © 2018 com.madteamlab. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
	
	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var roundedView: UIView!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var checkboxView: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()
		shadowView.backgroundColor = .clear
		shadowView.layer.shadowColor = UIColor.black.cgColor
		shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
		shadowView.layer.shadowOpacity = 0.3
		shadowView.layer.shadowRadius = 5
		
		roundedView.backgroundColor = .white
		roundedView.layer.cornerRadius = 5
		roundedView.clipsToBounds = true
		
		dateLabel.text = nil
		titleLabel.text = nil
		checkboxView.image = #imageLiteral(resourceName: "checkboxOff")
		
		selectionStyle = .none
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		checkboxView.image = selected ? #imageLiteral(resourceName: "checkboxOn") : #imageLiteral(resourceName: "checkboxOff")
		super.setSelected(selected, animated: animated)
	}
	
	var task: Task? {
		didSet {
			if let createdAt = task?.createdAt {
				let formatter = DateFormatter()
				formatter.dateFormat = "dd.MM.YYYY"
				dateLabel.text = formatter.string(from: createdAt)
			}
			titleLabel.text = task?.title
		}
	}
    
}
