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
    @IBOutlet weak var horoscopeLuckTextView: UITextView!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    var horoscope: Horoscope!
    var isFavorite: Bool = false
    
    var horoscopeLuck: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = horoscope.name
        
        horoscopeNameLabel.text = horoscope.name
        horosocopeDatesLabel.text = horoscope.dates
        horoscopeImageView.image = horoscope.getImage()
        
        isFavorite = SessionManager.isFavoriteHoroscope(id: horoscope.id)
        
        setFavoriteImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getHoroscopeLuck(period: "daily")
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
    
    @IBAction func didChangePeriod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getHoroscopeLuck(period: "daily")
        case 1:
            getHoroscopeLuck(period: "weekly")
        default:
            getHoroscopeLuck(period: "monthly")
        }
    }
    
    func getHoroscopeLuck(period:String) {
        guard let url = URL(string: "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/\(period)?sign=\(horoscope.id)&day=TODAY") else {
            return
        }
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)

                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    DispatchQueue.main.async {
                        self.loadingView.isHidden = true
                    }
                    return
                }
                
                let jsonData = json["data"] as? [String: String]
                
                horoscopeLuck = jsonData?["horoscope_data"] ?? ""
                
                DispatchQueue.main.async {
                    self.horoscopeLuckTextView.text = self.horoscopeLuck
                    self.loadingView.isHidden = true
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.loadingView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func share(_ sender: Any) {
        if let text = horoscopeLuck {
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            
            activityViewController.popoverPresentationController?.sourceView = self.view
            
            self.present(activityViewController, animated: true, completion: nil)
        }
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
