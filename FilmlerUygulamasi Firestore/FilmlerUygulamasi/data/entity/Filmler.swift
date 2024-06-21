//
//  Filmler.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 15.06.2024.
//

import Foundation

class Filmler {
    var id:String?
    var ad:String?
    var resim:String?
    var fiyat:Int?
    
    init() {
        
    }
    
    init(id: String, ad: String, resim: String, fiyat: Int) {
        self.id = id
        self.ad = ad
        self.resim = resim
        self.fiyat = fiyat
    }
}
