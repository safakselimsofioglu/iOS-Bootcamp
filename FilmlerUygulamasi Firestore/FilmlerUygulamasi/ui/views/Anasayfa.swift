//
//  ViewController.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 15.06.2024.
//

import UIKit
//import FirebaseFirestore
import Kingfisher

class Anasayfa: UIViewController {
    @IBOutlet weak var filmlerCollectionView: UICollectionView!
    var filmlerListesi = [Filmler]()
    var viewModel = AnasayfaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmlerCollectionView.dataSource = self
        filmlerCollectionView.delegate = self
        
        _ = viewModel.filmlerListesi.subscribe(onNext: { liste in
            self.filmlerListesi = liste
            DispatchQueue.main.async {
                self.filmlerCollectionView.reloadData()
            }
        })

        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //Çevre Boşluğu
        tasarim.minimumInteritemSpacing = 10 //Itemlar arası  boşluk
        tasarim.minimumLineSpacing = 10 //Dikey Boşluk
        
        //10x10x10 = 30
        let ekranGenislik = UIScreen.main.bounds.width //Ekran genişliğini verir
        let itemGenislik = (ekranGenislik - 30) / 2 //Item genişliği belirledik
        
        tasarim.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.65)
        filmlerCollectionView.collectionViewLayout = tasarim //tasarımı CollectionView'a aktardık.
         /*
        let db = Firestore.firestore()
        let collectionFilmler = db.collection("Filmler")
        let f1:[String:Any] = ["id": "", "ad": "Django", "resim": "django.png", "fiyat": 24]
        let f2:[String:Any] = ["id": "", "ad": "Interstellar", "resim": "interstellar.png", "fiyat": 32]
        let f3:[String:Any] = ["id": "", "ad": "Inception", "resim": "inception.png", "fiyat": 16]
        let f4:[String:Any] = ["id": "", "ad": "The Hateful Eight", "resim": "thehatefuleight.png", "fiyat": 28]
        let f5:[String:Any] = ["id": "", "ad": "The Pianist", "resim": "thepianist.png", "fiyat": 18]
        let f6:[String:Any] = ["id": "", "ad": "Anadoluda", "resim": "anadoluda.png", "fiyat": 10]
        collectionFilmler.document().setData(f1)
        collectionFilmler.document().setData(f2)
        collectionFilmler.document().setData(f3)
        collectionFilmler.document().setData(f4)
        collectionFilmler.document().setData(f5)
        collectionFilmler.document().setData(f6)
         */
    }
}

extension Anasayfa: UICollectionViewDelegate, UICollectionViewDataSource,HucreProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmlerListesi[indexPath.row]
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "filmlerHucre", for: indexPath) as! FilmlerHucre
        
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler_yeni/resimler/\(film.resim!)") {
            DispatchQueue.main.async {
                hucre.imageViewFilm.kf.setImage(with: url)
            }
        }
        
        hucre.labelFiyat.text = "\(film.fiyat!) ₺"
        hucre.layer.borderColor = UIColor.lightGray.cgColor
        hucre.layer.borderWidth = 0.3
        hucre.layer.cornerRadius = 10.0
        hucre.hucreProtocol = self
        hucre.indexPath = indexPath
        return hucre
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        performSegue(withIdentifier: "toDetay", sender: film)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            if let film = sender as? Filmler {
                let gidilecekVC = segue.destination as! DetaySayfa
                gidilecekVC.film = film
            }
        }
    }
    
    func sepeteEkleTikla(indexPath: IndexPath) {
        let film = filmlerListesi[indexPath.row]
        print("\(film.ad!) sepete eklendi")
    }
}

