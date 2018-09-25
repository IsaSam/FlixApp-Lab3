//
//  MovieCell.swift
//  FlixApp
//
//  Created by Isaac Samuel on 9/18/18.
//  Copyright © 2018 Isaac Samuel. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var MoviesImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
