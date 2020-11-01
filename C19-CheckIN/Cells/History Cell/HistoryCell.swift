//
//  HistoryCell.swift
//  C19-CheckIN
//
//  Created by Marko Koprivnjak on 01/11/2020.
//

import UIKit

class HistoryCell: UITableViewCell {
	@IBOutlet weak var lblRoomName: UILabel!
	@IBOutlet weak var lblStartTime: UILabel!
	@IBOutlet weak var lblEndTime: UILabel!
	@IBOutlet weak var lblDuration: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func setup(_ model: HistoryCellModel) {
		lblRoomName.text = model.roomTitle
		lblStartTime.text = model.startTime
		lblEndTime.text = model.endTime
		lblDuration.text = model.duration
	}
}
