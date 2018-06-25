//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Chandra Rao on 28/11/17.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovies: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contentView.backgroundColor = UIColor.black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
