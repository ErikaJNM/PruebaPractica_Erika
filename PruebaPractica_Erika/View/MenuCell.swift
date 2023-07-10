//
//  MenuCell.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var lbltitulo: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
