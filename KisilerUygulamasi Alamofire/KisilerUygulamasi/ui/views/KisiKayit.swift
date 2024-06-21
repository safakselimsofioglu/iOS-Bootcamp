//
//  KisiKayit.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 14.06.2024.
//

import UIKit

class KisiKayit: UIViewController {
    @IBOutlet weak var tfKisiTel: UITextField!
    @IBOutlet weak var tfKisiAd: UITextField!
    
    var viewModel = KisiKayitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func buttonKaydet(_ sender: Any) {
        if let ka = tfKisiAd.text, let kt = tfKisiTel.text {
            viewModel.kaydet(kisi_ad: ka, kisi_tel: kt)
            //Verileri alır ve KisiKayitViewModel sınıfına gönderir.
        }
    }
    
}
