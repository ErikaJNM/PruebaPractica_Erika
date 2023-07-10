//
//  ComentariosController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit

class ComentariosController: UIViewController {
    @IBOutlet weak var txtViewComentarios: UITextView!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var fotoPrincipal: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fotoPrincipal.layer.cornerRadius = 60
        fotoPrincipal.layer.masksToBounds = true
        fotoPrincipal.image = UIImage(named: "foto")

        lblNombre.text = "Erika Jaquelinne Navarrete Miranda"
        txtViewComentarios.text = ""
        
    }
    

    @IBAction func btnRegresar() {
        dismiss(animated: true)
    }
    

}

