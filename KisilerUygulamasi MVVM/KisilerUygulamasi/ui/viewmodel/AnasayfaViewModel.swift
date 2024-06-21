//
//  AnasayfaViewModel.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
    var krepo = KisilerDaoRepository()
    var kisilerListesi = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    //KisilerDaoRepo'dan gelen burayı tetikliyor.
    
    //Anasayfada viewModel nesnesi oluşturulduğu için init çalıştı.
    init() {
        kisilerListesi = krepo.kisilerListesi
        //repodaki RxSwift yapısı ile buradaki RxSwift yapısı bağlandı.
        kisileriYukle()
        //Daha sonra verileri yükledi.
    }
    
    func sil(kisi_id:Int){
        krepo.sil(kisi_id: kisi_id)
        kisileriYukle()
    }
    
    func ara(searchText:String){
        krepo.ara(searchText: searchText)
    }
    
    func kisileriYukle(){
        krepo.kisileriYukle()
        //Repodaki kisileri yukle çalıştırıldı.
    }
    
}
