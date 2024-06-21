//
//  KisilerDaoRepository.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation
import RxSwift
import CoreData

class KisilerDaoRepository {
    var kisilerListesi = BehaviorSubject<[KisilerModel]>(value: [KisilerModel]())
    
    let context = appDelegate.persistentContainer.viewContext //Model'e ulaşmak için
    
    func kaydet(kisi_ad:String, kisi_tel:String){
        let kisi = KisilerModel(context: context)
        kisi.kisi_ad = kisi_ad
        kisi.kisi_tel = kisi_tel //Nesne oluşturma tamamlandı
        appDelegate.saveContext() //Kaydedildi
    }
    
    func guncelle(kisi:KisilerModel, kisi_ad:String, kisi_tel:String){
        kisi.kisi_ad = kisi_ad
        kisi.kisi_tel = kisi_tel
        appDelegate.saveContext()
    }
    
    func sil(kisi:KisilerModel){
        context.delete(kisi)
        appDelegate.saveContext()
        kisileriYukle()
    }
    
    func ara(searchText:String){
        do{
            let fr = KisilerModel.fetchRequest()
            fr.predicate = NSPredicate(format: "kisi_ad CONTAINS[c] %@", searchText)
            let liste = try context.fetch(fr)
            kisilerListesi.onNext(liste)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func kisileriYukle(){
        do{
            let liste = try context.fetch(KisilerModel.fetchRequest()) //Tabloyu okuma işlemi
            kisilerListesi.onNext(liste)
            //Tetikleme: Bu gidiyor AnasayfaViewModel'daki kisilerListesi'ni tetikliyor.
        }catch{
            print(error.localizedDescription)
        }
    }
}
