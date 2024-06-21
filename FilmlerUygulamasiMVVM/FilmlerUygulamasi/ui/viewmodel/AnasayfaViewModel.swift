//
//  AnasayfaViewModel.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var frepo = FilmlerDaoRepository()
    var filmlerListesi = BehaviorSubject<[Filmler]>(value: [Filmler]()) //arayüzü besleyecek
    
    init() {
        filmlerListesi = frepo.filmlerListesi
        filmleriYukle()
    }
    
    func filmleriYukle(){
        frepo.filmleriYukle()
    }
}
