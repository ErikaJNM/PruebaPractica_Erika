//
//  SideController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit

class SideController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemOrange
        
        let width = UIScreen.main.bounds.width / 2
        let height = UIScreen.main.bounds.height
        let x = UIScreen.main.bounds.width
        let y: CGFloat = 0
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.isHidden = true
        
        view.addSubview(button)
        view.addSubview(button2)
    }
    
    
    private var button : UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Configuración"
        
        let button = UIButton(frame: CGRect(x: 10, y: 300, width: 170, height: 70))
        button.translatesAutoresizingMaskIntoConstraints = true
        button.tintColor = UIColor.systemOrange
        button.setTitleColor(.black, for: .normal)
        button.configuration = configuration
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.tag = 1
        button.backgroundColor = UIColor.lightGray
        
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button Clic")
       let viewController = UIApplication.shared.keyWindow?.rootViewController as? ConfiguracionesController
    }
    
    private var button2 : UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Comentarios"
        
        let button2 = UIButton(frame: CGRect(x: 10, y: 600, width: 170, height: 70))
        button2.translatesAutoresizingMaskIntoConstraints = true
        button2.tintColor = UIColor.systemOrange
        button2.setTitleColor(.black, for: .normal)
        button2.configuration = configuration
        button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside)
        button2.tag = 1
        button2.backgroundColor = UIColor.lightGray
        
        return button2
    }()
    
    @objc func buttonAction2(sender: UIButton!) {
        print("Button Clic")
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
    
}


