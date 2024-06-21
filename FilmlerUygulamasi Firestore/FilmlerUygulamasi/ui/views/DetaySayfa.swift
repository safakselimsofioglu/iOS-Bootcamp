//
//  DetaySayfa.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 15.06.2024.
//

import UIKit
import Kingfisher

class DetaySayfa: UIViewController {

    @IBOutlet weak var labelFilm: UILabel!
    @IBOutlet weak var imageViewFilm: UIImageView!
    @IBOutlet weak var labelFiyat: UILabel!
    
    var film:Filmler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let film = film {
            labelFilm.text = film.ad
            if let url = URL(string: "http://kasimadalan.pe.hu/filmler_yeni/resimler/\(film.resim!)") {
                DispatchQueue.main.async {
                    self.imageViewFilm.kf.setImage(with: url)
                }
            }
            labelFiyat.text = "\(film.fiyat!) ₺"
        }
        
    }

}
