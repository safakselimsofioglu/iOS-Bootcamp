//
//  KisiDetayViewModel.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation

class KisiDetayViewModel {
    
    var krepo = KisilerDaoRepository()
    func guncelle(kisi:KisilerModel, kisi_ad:String, kisi_tel:String){
        krepo.guncelle(kisi:kisi, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
    }
    
}
