//
//  ConfiguracionesController.swift
//  PruebaPractica_Erika
//
//  Created by MacBookMBA1 on 06/07/23.
//

import UIKit
import AVFoundation

class ModelCell{
    let name : String
    var isSelected : Bool
    
    init(name: String, isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
    init(){
        self.name = ""
        self.isSelected = false
    }
}
class ConfiguracionesController: UIViewController {
    
    var selectSource = [
        ModelCell(name: "Vibración y Sonido", isSelected: false),
        ModelCell(name: "Sólo Sonido", isSelected: false),
        ModelCell(name: "Solo Vibración", isSelected: false)
       ]
    var player = Sounds().player

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "MenuCell", bundle: .main), forCellReuseIdentifier: "MenuCell")
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
    
    }
    
    @IBAction func btnSonidos(_ sender: UIButton) {
        var player1 = Sounds()
        
        
        var btnElegido = sender.titleLabel?.text
        
        if btnElegido == "Sonido 1" {
            do{
                let url = Bundle.main.url(forResource: "alarma-morning-mix", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }catch{
                print(error)
            }
        }else{
            do{
                let url = Bundle.main.url(forResource: "alarm-clock", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }catch{
                print(error)
            }
        }
        
    }
    
    
    
    @IBAction func btnVibration(_ sender: UIButton) {
        var btnElegido = sender.titleLabel?.text
        
        if btnElegido == "Vibración 1"{
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
    }
    
    
}
