//
//  SideController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit

class SideController: UIViewController {
    
    
    private var ImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 270, width: 50, height: 50))
        imageView.image = UIImage (systemName: "gearshape.fill")
        imageView.tintColor = UIColor.systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = true
        
        return imageView
    }()
    
    private var ImageView2 : UIImageView = {
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 570, width: 50, height: 50))
        imageView2.image = UIImage (systemName: "note.text")
        imageView2.tintColor = UIColor.systemGray
        imageView2.translatesAutoresizingMaskIntoConstraints = true
        
        return imageView2
    }()
    
    private var button : UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Configuración"
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.systemOrange
        button.setTitleColor(.black, for: .normal)
        button.configuration = configuration
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = 1
        button.backgroundColor = UIColor.lightGray
        
        return button
    }()
    
    
    
    private var button2 : UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Comentarios"
        let button2 = UIButton()
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.tintColor = UIColor.systemOrange
        button2.setTitleColor(.black, for: .normal)
        button2.configuration = configuration
        button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        button2.tag = 1
        button2.backgroundColor = UIColor.lightGray
        
        return button2
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemOrange
        
        let width = UIScreen.main.bounds.width / 2
        let height = UIScreen.main.bounds.height
        let x = UIScreen.main.bounds.width
        let y: CGFloat = 130
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.isHidden = true
        
        [ImageView,button,ImageView2,button2].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            
            button.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 250),
            button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -480),
            button.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: ImageView.rightAnchor, constant: 0),
            button2.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 550),
            button2.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -180),
            button2.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: 0),
            button2.leftAnchor.constraint(equalTo: ImageView2.rightAnchor, constant: 0),
        ]
        )
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.x = UIScreen.main.bounds.width / 2
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.isHidden = true
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button Clic")
        goToNextView()
    }
    
    func goToNextView() {
        let destViewController = ConfiguracionesController()
        guard let window = UIApplication.shared.windows.first else {
            return
        }
        
        window.rootViewController = destViewController
        window.makeKeyAndVisible()
    }
    
    @objc func buttonAction2(sender: UIButton!) {
        print("Button Comentarios")
    }
}


