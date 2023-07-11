//
//  SideController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ btn: String)
}

class SideController: UIViewController {
    
    var delegate: SideMenuViewControllerDelegate?
    
    private var stackConfiguracion : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var stackConfiguracion1 : UIStackView = {
        let stackView1 = UIStackView()
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        return stackView1
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
        
        [stackConfiguracion,stackConfiguracion1].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            stackConfiguracion.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 250),
            stackConfiguracion.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackConfiguracion.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackConfiguracion1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 500),
            stackConfiguracion1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackConfiguracion1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
        
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.plain()
        button.setTitle("Configuración", for: .normal)
        button.setTitleColor(.white, for: .normal)
        configuration.image = UIImage(systemName: "gearshape.fill")?.withTintColor(UIColor.systemGray).withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        button.imageEdgeInsets = UIEdgeInsets(top: 25.0, left: 25.0, bottom: 25.0, right: 25.0)
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .systemOrange
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = 1
        button.configuration = configuration
        
        stackConfiguracion.addArrangedSubview(button)
            
        let button1 = UIButton(type: .system)
        var configuration1 = UIButton.Configuration.plain()
        button1.setTitle("Comentarios", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        configuration1.image = UIImage(systemName: "note.text")?.withTintColor(.systemGray, renderingMode: UIImage.RenderingMode.alwaysOriginal)
        configuration1.imagePadding = 10
        configuration1.baseBackgroundColor = .systemOrange
        button1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button1.tag = 1
        button1.configuration = configuration1
            
        stackConfiguracion1.addArrangedSubview(button1)
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
        let btnElegido = sender.titleLabel?.text
        self.delegate?.selectedCell(btnElegido!)
    }
}


