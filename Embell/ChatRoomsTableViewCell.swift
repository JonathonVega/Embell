//
//  ChatRoomsTableViewCell.swift
//  Embell
//
//  Created by Jonathon F Vega on 3/11/17.
//  Copyright © 2017 Jonathon Vega. All rights reserved.
//

import UIKit

class ChatRoomsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatRoomImage: UIImageView!
    @IBOutlet weak var chatRoomName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
