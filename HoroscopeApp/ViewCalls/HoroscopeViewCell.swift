//
//  HoroscopeViewCellTableViewCell.swift
//  HoroscopeApp
//
//  Created by Tardes on 13/6/25.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {
    
    @IBOutlet weak var horoscopeImageView: UIImageView!
    @IBOutlet weak var horoscopeNameLabel: UILabel!
    @IBOutlet weak var horosocopeDatesLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    func render(horoscope: Horoscope) {
        horoscopeNameLabel.text = horoscope.name
        horosocopeDatesLabel.text = horoscope.dates
        horoscopeImageView.image = horoscope.getImage()
        favoriteImageView.isHidden = !SessionManager.isFavoriteHoroscope(id: horoscope.id)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
