//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation
import RxSwift

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    func kaydet(kisi_ad:String, kisi_tel:String){
        print("Kişi Kaydet : \(kisi_ad) - \(kisi_tel)")
    }
    
    func guncelle(kisi_id:Int, kisi_ad:String, kisi_tel:String){
        print("Kişi Günelle : \(kisi_id) - \(kisi_ad) - \(kisi_tel)")
    }
    
    func sil(kisi_id:Int){
        print("Kişi Sil : \(kisi_id)")
    }
    
    func ara(searchText:String){
        print("Kişi Ara : \(searchText)")
    }
    
    func kisileriYukle(){
        var liste = [Kisiler]()
        let k1 = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "1111")
        let k2 = Kisiler(kisi_id: 2, kisi_ad: "Zeynep", kisi_tel: "2222")
        let k3 = Kisiler(kisi_id: 3, kisi_ad: "Beyza", kisi_tel: "3333")
        liste.append(k1)
        liste.append(k2)
        liste.append(k3)
        kisilerListesi.onNext(liste)
        //Tetikleme: Bu gidiyor AnasayfaViewModel'daki kisilerListesi'ni tetikliyor.
    }
}
