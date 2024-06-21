//
//  DetaySayfa.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 15.06.2024.
//

import UIKit

class DetaySayfa: UIViewController {

    @IBOutlet weak var labelFilm: UILabel!
    @IBOutlet weak var imageViewFilm: UIImageView!
    @IBOutlet weak var labelFiyat: UILabel!
    
    var film:Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let film = film {
            labelFilm.text = film.ad
            imageViewFilm.image = UIImage(named: film.resim!)
            labelFiyat.text = "\(film.fiyat!) ₺"
        }
        
    }

}
