//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation
import RxSwift
import FirebaseFirestore

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    var collectionKisiler = Firestore.firestore().collection("Kisiler") //İlk kayıtta bu isimde tablo oluşturur.
    
    func kaydet(kisi_ad:String, kisi_tel:String){
        let yeniKisi:[String:Any] = ["kisi_id":"", "kisi_ad":kisi_ad, "kisi_tel":kisi_tel]
        collectionKisiler.document().setData(yeniKisi)
    }
    
    func guncelle(kisi_id:String, kisi_ad:String, kisi_tel:String){
        let guncellenenKisi:[String:Any] = ["kisi_ad":kisi_ad, "kisi_tel":kisi_tel]
        collectionKisiler.document(kisi_id).updateData(guncellenenKisi)
    }
    
    func sil(kisi_id:String){
        collectionKisiler.document(kisi_id).delete()
    }
    
    func ara(searchText:String){
        collectionKisiler.addSnapshotListener{ snapshot, error in
            var liste = [Kisiler]()
            if let documents = snapshot?.documents { //Tüm verilere erişilir
                for document in documents {
                    let data = document.data()
                    let kisi_id = document.documentID
                    let kisi_ad = data["kisi_ad"] as? String ?? ""
                    let kisi_tel = data["kisi_tel"] as? String ?? ""
                    if kisi_ad.lowercased().contains(searchText.lowercased()) {
                        let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                        liste.append(kisi)
                    }
                }
            }
            self.kisilerListesi.onNext(liste)
            //Tetikleme: Bu gidiyor AnasayfaViewModel'daki kisilerListesi'ni tetikliyor.
        }
    }
    
    func kisileriYukle(){
        collectionKisiler.addSnapshotListener{ snapshot, error in
            var liste = [Kisiler]()
            if let documents = snapshot?.documents { //Tüm verilere erişilir
                for document in documents {
                    let data = document.data()
                    let kisi_id = document.documentID
                    let kisi_ad = data["kisi_ad"] as? String ?? ""
                    let kisi_tel = data["kisi_tel"] as? String ?? ""
                    let kisi = Kisiler(kisi_id: kisi_id, kisi_ad: kisi_ad, kisi_tel: kisi_tel)
                    liste.append(kisi)
                }
            }
            self.kisilerListesi.onNext(liste)
            //Tetikleme: Bu gidiyor AnasayfaViewModel'daki kisilerListesi'ni tetikliyor.
        }
        
    }
}
