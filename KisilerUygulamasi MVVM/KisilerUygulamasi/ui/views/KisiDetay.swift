//
//  KisiDetay.swift
//  KisilerUygulamasi
//
//  Created by Şafak Selim Sofioğlu on 14.06.2024.
//

import UIKit

class KisiDetay: UIViewController {
    @IBOutlet weak var tfKisiAd: UITextField!
    @IBOutlet weak var tfKisiTel: UITextField!
    
    var kisi:Kisiler?
    
    var viewModel = KisiDetayViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let k = kisi {
            tfKisiAd.text = k.kisi_ad
            tfKisiTel.text = k.kisi_tel
        }

    }
    
    @IBAction func buttonGuncelle(_ sender: Any) {
        if let ka = tfKisiAd.text, let kt = tfKisiTel.text, let k = kisi {
            viewModel.guncelle(kisi_id: k.kisi_id!, kisi_ad: ka, kisi_tel: kt)
        }
    }
    
}
