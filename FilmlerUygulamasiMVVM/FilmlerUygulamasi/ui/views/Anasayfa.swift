//
//  ViewController.swift
//  FilmlerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 15.06.2024.
//

import UIKit

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
            self.filmlerCollectionView.reloadData()
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
    }
}

extension Anasayfa: UICollectionViewDelegate, UICollectionViewDataSource,HucreProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmlerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmlerListesi[indexPath.row]
        let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "filmlerHucre", for: indexPath) as! FilmlerHucre
        hucre.imageViewFilm.image = UIImage(named: film.resim!)
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

