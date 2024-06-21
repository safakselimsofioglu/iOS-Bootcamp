//
//  ViewController.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 14.06.2024.
//

import UIKit

class Anasayfa: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    var kisilerListesi = [Kisiler]()
    
    var viewModel = AnasayfaViewModel() //Uygulama açıldığı anda bir viewModel nesnesi oluşturuldu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self //Protokolü aktifleştirdik
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        _ = viewModel.kisilerListesi.subscribe(onNext: { liste in
            self.kisilerListesi = liste
            self.kisilerTableView.reloadData()
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.kisileriYukle()
    }
    
    //KisiDetay sayfasına geçiş yaparken ki işlemler:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            //sender Any türünde downcasting yapmamız gerekiyor.
            if let kisi = sender as? Kisiler {
                let gidilecekVC = segue.destination as! KisiDetay
                gidilecekVC.kisi = kisi
                //KisiDetay sayfasında kisi nesnesine burada oluşturduğumuz kişi nesnesini aktardık.
            }
        }
    }
}

extension Anasayfa: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.ara(searchText: searchText)
    }
}

extension Anasayfa: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListesi[indexPath.row] //nesnelere erişildi.
        let hucre = tableView.dequeueReusableCell(withIdentifier: "kisilerHucre") as! kisilerHucre //hücreye erişildi.
        hucre.labelKisiAd.text = kisi.kisi_ad!
        hucre.labelKisiTel.text = kisi.kisi_tel!
        return hucre
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kisi = kisilerListesi[indexPath.row] //Hangi satıra tıklandıysa oradaki bilgileri aldık.
        performSegue(withIdentifier: "toDetay", sender: kisi) //KisiDetay sayfasına kisi nesnesini yolladık.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Sağdan kaydırma işlemi
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){contextualAction,view,bool in
            let kisi = self.kisilerListesi[indexPath.row]
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(kisi.kisi_ad!) silinsin mi?", preferredStyle: .alert)
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.sil(kisi_id: kisi.kisi_id!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
