//
//  FilmlerDaoRepository.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 17.06.2024.
//

import Foundation
import RxSwift
import Alamofire

class FilmlerDaoRepository {
    var filmlerListesi = BehaviorSubject<[Filmler]>(value: [Filmler]())
    
    func filmleriYukle(){
        AF.request("http://kasimadalan.pe.hu/filmler_yeni/tum_filmler.php", method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(FilmlerCevap.self, from: data)
                    if let liste = cevap.filmler {
                        self.filmlerListesi.onNext(liste) //Bunun sayesinde ViewModel'a veri göndermiş oluruz.
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
