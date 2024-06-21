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
        veritabaniKopyala()
        kisilerListesi = krepo.kisilerListesi
        //repodaki RxSwift yapısı ile buradaki RxSwift yapısı bağlandı.
        kisileriYukle()
        //Daha sonra verileri yükledi.
    }
    
    func sil(kisi_id:Int){
        krepo.sil(kisi_id: kisi_id)
    }
    
    func ara(aramaKelimesi:String){
        krepo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func kisileriYukle(){
        krepo.kisileriYukle()
        //Repodaki kisileri yukle çalıştırıldı.
    }
    
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "rehber", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("rehber.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}
