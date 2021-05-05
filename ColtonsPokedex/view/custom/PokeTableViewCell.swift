//
//  PokeTableViewCell.swift
//  ColtonsPokedex
//
//  Created by Gavin Craft on 5/4/21.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    //MARK: - iboutlets
    @IBOutlet var viewForPicOfPoke: UIImageView!
    @IBOutlet var labelForName: UILabel!
    @IBOutlet var labelForId: UILabel!
    //MARK: - properties
    var poke: StoredPokeman?
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadData(){
        guard let poke = poke else {return}
        labelForName.text = poke.poke.name
        labelForId.text = "ID: \(poke.poke.id)"
        viewForPicOfPoke.image = UIImage(data: poke.image)
    }
}
