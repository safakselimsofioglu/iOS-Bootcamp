//
//  KisiKayitViewModel.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation

class KisiKayitViewModel {
    
    var krepo = KisilerDaoRepository()
    func kaydet(kisi_ad:String, kisi_tel:String){
        krepo.kaydet(kisi_ad: kisi_ad, kisi_tel: kisi_tel)
    }
    //Burada da verileri alıp KisilerDaoRepository'e gönderir.
    
}
