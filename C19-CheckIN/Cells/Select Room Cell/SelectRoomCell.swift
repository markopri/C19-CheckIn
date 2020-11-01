//
//  SelectRoomCell.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class SelectRoomCell: UITableViewCell {
	@IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func setup(_ model: SelectRoomCellModel) {
		lblTitle.text = model.title
	}
}
