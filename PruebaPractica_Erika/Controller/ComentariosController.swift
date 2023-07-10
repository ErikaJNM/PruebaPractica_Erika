//
//  ComentariosController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit

class ComentariosController: UIViewController {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var lblComentarios: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var fotoPrincipal: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fotoPrincipal.layer.cornerRadius = 60
        fotoPrincipal.layer.masksToBounds = true
        fotoPrincipal.image = UIImage(named: "foto")

        lblNombre.text = "Erika Jaquelinne Navarrete Miranda"
        lblComentarios.text = "La prueba se me hizo muy interesante ya que utilice nuevas herramientas que me permiten utilizar la posicion de iphone."
        
    }
    

    @IBAction func btnRegresar() {
        dismiss(animated: true)
    }
    

}

