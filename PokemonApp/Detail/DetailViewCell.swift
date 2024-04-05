//
//  DetailViewCell.swift
//  PokemonApp
//
//  Created by Sultan Rifaldy on 04/04/24.
//

import UIKit


protocol DetailViewCellDelegate: AnyObject {
    func detailViewCellCatchButtonTapped(_ cell: DetailViewCell)
}

class DetailViewCell: UITableViewCell {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var moveLabel: UILabel!
    @IBOutlet weak var cathcButtonLabel: UIButton!
    
    weak var delegate: DetailViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func catchButtonTapped(_ sender: Any) {
        let image = detailImageView.image
        delegate?.detailViewCellCatchButtonTapped(self)
    }
    
}
