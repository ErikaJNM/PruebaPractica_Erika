//
//  ConfiguracionesController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit
import AVFoundation

class ConfiguracionesController: UIViewController {
    @IBOutlet weak var btnVibracion2: UIButton!
    @IBOutlet weak var btnVibracíon1: UIButton!
    @IBOutlet weak var btnSonido2: UIButton!
    @IBOutlet weak var btnSonido1: UIButton!
    
    let userDefault = UserDefaults.standard

    var user = UserDefault()
    var selectSource = [
        ModelCell(name: "Vibración y Sonido", isSelected: false),
        ModelCell(name: "Sólo Sonido", isSelected: false),
        ModelCell(name: "Solo Vibración", isSelected: false)
       ]
    var player = Sounds().player

    @IBOutlet weak var tableView: UITableView?
    override func viewDidLoad() {
        tableView?.register(UINib(nibName: "MenuCell", bundle: .main), forCellReuseIdentifier: "MenuCell")
        tableView?.dataSource = self
        tableView?.delegate = self
        super.viewDidLoad()
    
        
        let opcion = userDefault.string(forKey: "opcion")
        let sonido = userDefault.string(forKey: "Sonido")
        let vibracion = userDefault.string(forKey: "Vibracion")
        
        if opcion == nil{
            selectSource[0].isSelected = true
        }else{
            if opcion == selectSource[0].name{
                selectSource[0].isSelected = true
            }else{
                if opcion == selectSource[1].name{
                    selectSource[1].isSelected = true
                }else{
                    selectSource[2].isSelected = true
                }
            }
        }
        
        if sonido == nil{
            btnSonido1.backgroundColor = UIColor.systemGray
            btnSonido2.backgroundColor = UIColor.white
        }else{
            if sonido == "Sonido 1"{
                btnSonido1.backgroundColor = UIColor.systemGray
                btnSonido2.backgroundColor = UIColor.white
            }else{
                btnSonido2.backgroundColor = UIColor.systemGray
                btnSonido1.backgroundColor = UIColor.white
            }
        }
        
        if vibracion == nil{
            btnVibracíon1.backgroundColor = UIColor.systemGray
            btnVibracion2.backgroundColor = UIColor.white
        }else{
            if vibracion == "Vibración 1"{
                btnVibracíon1.backgroundColor = UIColor.systemGray
                btnVibracion2.backgroundColor = UIColor.white
            }else{
                btnVibracion2.backgroundColor = UIColor.systemGray
                btnVibracíon1.backgroundColor = UIColor.white
            }
        }
    }
    
    @IBAction func btnSonidos(_ sender: UIButton) {        
        
        var btnElegido = sender.titleLabel?.text
        
        if btnElegido == "Sonido 1" {
            self.userDefault.removeObject(forKey: "Sonido")
            user.sonido = btnElegido!
            self.userDefault.set(user.sonido, forKey: "Sonido")
            btnSonido1.backgroundColor = UIColor.lightGray
            btnSonido2.backgroundColor = UIColor.white
            do{
                let url = Bundle.main.url(forResource: "alarma-morning-mix", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }catch{
                print(error)
            }
        }else{
            self.userDefault.removeObject(forKey: "Sonido")
            user.sonido = btnElegido!
            self.userDefault.set(user.sonido, forKey: "Sonido")
            btnSonido2.backgroundColor = UIColor.lightGray
            btnSonido1.backgroundColor = UIColor.white
            do{
                let url = Bundle.main.url(forResource: "alarm-clock", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }catch{
                print(error)
            }
        }
        
    }
    
    
    @IBAction func btnRegresar() {
        dismiss(animated: false)
    }
    
    @IBAction func btnVibration(_ sender: UIButton) {
        var btnElegido = sender.titleLabel?.text
        
        if btnElegido == "Vibración 1"{
            self.userDefault.removeObject(forKey: "Vibracion")
            user.vibracion = btnElegido!
            self.userDefault.set(user.vibracion, forKey: "Vibracion")
            btnVibracíon1.backgroundColor = UIColor.lightGray
            btnVibracion2.backgroundColor = UIColor.white
            let sequence: [VibrationMode] = [.light, .medium, .heavy, .medium, .light]
            var currentIndex = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if currentIndex < sequence.count {
                    Settings.vibrate(mode: sequence[currentIndex])
                    currentIndex += 1
                } else {
                    timer.invalidate()
                }
            }
        }else{
            self.userDefault.removeObject(forKey: "Vibracion")
            user.vibracion = btnElegido!
            self.userDefault.set(user.vibracion, forKey: "Vibracion")
            btnVibracion2.backgroundColor = UIColor.lightGray
            btnVibracíon1.backgroundColor = UIColor.white
            let sequence: [VibrationMode] = [.heavy, .heavy, .heavy]
            var currentIndex = 0
            
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                if currentIndex < sequence.count {
                    Settings.vibrate(mode: sequence[currentIndex])
                    currentIndex += 1
                } else {
                    timer.invalidate()
                }
            }
        }
    }
    
}

extension ConfiguracionesController : UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.imageLogo.isHidden = false
        if selectSource[indexPath.row]
            .isSelected{
            cell.imageLogo!.image = UIImage(named:"check")!
        } else {
            cell.imageLogo!.image = UIImage(named: "notCheck")
        }
        
        let op = indexPath.row
        
        switch op {
            case 0:
                cell.lbltitulo.text = selectSource[indexPath.row].name
                return cell
                break
            case 1:
                cell.lbltitulo.text = selectSource[indexPath.row].name
                return cell
                break
            case 2:
                cell.lbltitulo.text = selectSource[indexPath.row].name
                return cell
                break
            default:
                break
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectSource.filter{$0.isSelected == true}.map{$0.isSelected = false}
        let currentItem = selectSource[indexPath.row]
        currentItem.isSelected = true
        tableView.reloadData()
        
        user.opcion = currentItem.name
        self.userDefault.set(user.opcion, forKey: "opcion")
    }
}
