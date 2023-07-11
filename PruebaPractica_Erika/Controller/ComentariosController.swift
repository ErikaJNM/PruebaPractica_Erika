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
        txtViewComentarios.text = "La prueba se me hizo muy interesante, ya que puse aprueba mis habilidades y conocimientos como desarrolladora iOS, considero que se me dificulto un poco lo del menuSide, ya que me puse el reto de hacerlo de una forma diferente a lo habitual, realizándolo de manera nativa, y con vista programáticas, esto lo hice agregando una subview a la vista principal, y lo que más se me facilito fue el diseño de las vistas, es un área en la cual me considero buena."
        
    }
    

    @IBAction func btnRegresar() {
        dismiss(animated: true)
    }
    

}

