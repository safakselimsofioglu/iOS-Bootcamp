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
    var kisilerListesi = BehaviorSubject<[KisilerModel]>(value: [KisilerModel]())
    //KisilerDaoRepo'dan gelen burayı tetikliyor.
    
    //Anasayfada viewModel nesnesi oluşturulduğu için init çalıştı.
    init() {
        kisilerListesi = krepo.kisilerListesi
        //repodaki RxSwift yapısı ile buradaki RxSwift yapısı bağlandı.
        kisileriYukle()
        //Daha sonra verileri yükledi.
    }
    
    func sil(kisi:KisilerModel){
        krepo.sil(kisi: kisi)
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
