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
    
    var horoscope: Horoscope!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = horoscope.name

        horoscopeNameLabel.text = horoscope.name
        horosocopeDatesLabel.text = horoscope.dates
        horoscopeImageView.image = horoscope.getImage()
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
