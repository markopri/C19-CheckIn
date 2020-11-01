//
//  SettingsCell.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class SettingsCell: UITableViewCell {
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setup(_ model: SettingsCellModel) {
		iconImageView.image = UIImage(named: model.icon)
		lblTitle.text = model.title
		lblTitle.adjustsFontSizeToFitWidth = true
	}
}
