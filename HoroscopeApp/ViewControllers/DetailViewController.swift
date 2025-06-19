//
//  DetailViewController.swift
//  HoroscopeApp
//
//  Created by Tardes on 17/6/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var horoscopeImageView: UIImageView!
    @IBOutlet weak var horoscopeNameLabel: UILabel!
    @IBOutlet weak var horosocopeDatesLabel: UILabel!
    
    @IBOutlet weak var favoriteMenu: UIBarButtonItem!
    
    var horoscope: Horoscope!
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = horoscope.name

        horoscopeNameLabel.text = horoscope.name
        horosocopeDatesLabel.text = horoscope.dates
        horoscopeImageView.image = horoscope.getImage()
        
        isFavorite = SessionManager.isFavoriteHoroscope(id: horoscope.id)
        
        setFavoriteImage()
    }
    
    func setFavoriteImage() {
        favoriteMenu.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    @IBAction func setFavorite(_ sender: Any) {
        isFavorite = !isFavorite
        if isFavorite {
            SessionManager.setFavoriteHoroscope(id: horoscope.id)
        } else {
            SessionManager.setFavoriteHoroscope(id: "")
        }
        setFavoriteImage()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
