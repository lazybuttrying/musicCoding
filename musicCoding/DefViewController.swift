//
//  DefViewController.swift
//  testForMidi
//
//  Created by 김산들 on 05/03/2020.
//  Copyright © 2020 김산들. All rights reserved.
//

import UIKit
import AudioKit
import AVFoundation
import Foundation
var fitems: [String] = ["솔","미","미","쉼표","파","레","레","쉼표","지워지지 않아요"]
//"도","미","솔","솔","미","미","미","쉼표",
var fcurrentRow:Int = 0
var fstartPoint:Int = 0


protocol SendDataDelegate {
    func sendData(data: String, list:[String])
}

class DefViewController: UIViewController,UITextFieldDelegate {

   var delegate: SendDataDelegate?
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var doButton: UIButton!
    @IBOutlet weak var reButton: UIButton!
    @IBOutlet weak var miButton: UIButton!
    @IBOutlet weak var faButton: UIButton!
    @IBOutlet weak var solButton: UIButton!
    @IBOutlet weak var laButton: UIButton!
    @IBOutlet weak var siButton: UIButton!
    @IBOutlet weak var doUpButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var ifButton: UIButton!
    @IBOutlet weak var loopStartButton: UIButton!
    @IBOutlet weak var loopEndButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
   
    
    var audioDo = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound1",ofType:"mp3")!)
    var audioRe = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound2",ofType:"mp3")!)
    var audioMi = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound3",ofType:"mp3")!)
    var audioFa = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound4",ofType:"mp3")!)
    var audioSol = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound5",ofType:"mp3")!)
    var audioLa = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound6",ofType:"mp3")!)
    var audioSi = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound7",ofType:"mp3")!)
    var audioDoUp = NSURL(fileURLWithPath: Bundle.main.path(forResource: "sound8",ofType:"mp3")!)
    var playerDo = AVAudioPlayer()
    var playerRe = AVAudioPlayer()
    var playerMi = AVAudioPlayer()
    var playerFa = AVAudioPlayer()
    var playerSol = AVAudioPlayer()
    var playerLa = AVAudioPlayer()
    var playerSi = AVAudioPlayer()
    var playerDoUp = AVAudioPlayer()
    
    @objc func ButtonClicked(_ sender: UIButton){
             NSLog("\(items)")
             myTableView.reloadData()
             fcurrentRow += 1
         }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defNameInput.delegate = self
        func addTargetToButton(button: UIButton){
                 button.addTarget(self, action:  #selector(self.ButtonClicked(_:)), for: .touchUpInside)
             }
        addTargetToButton(button: doButton)
        addTargetToButton(button: reButton)
        addTargetToButton(button: miButton)
        addTargetToButton(button: miButton)
        addTargetToButton(button: faButton)
        addTargetToButton(button: solButton)
        addTargetToButton(button: laButton)
        addTargetToButton(button: siButton)
        addTargetToButton(button: doUpButton)
        addTargetToButton(button: pauseButton)
        addTargetToButton(button: ifButton)
        addTargetToButton(button: loopEndButton)

         do{
            playerDo = try AVAudioPlayer(contentsOf: audioDo as URL)
             playerRe = try AVAudioPlayer(contentsOf: audioRe as URL)
             playerMi = try AVAudioPlayer(contentsOf: audioMi as URL)
             playerFa = try AVAudioPlayer(contentsOf: audioFa as URL)
             playerSol = try AVAudioPlayer(contentsOf: audioSol as URL)
             playerLa = try AVAudioPlayer(contentsOf: audioLa as URL)
             playerSi = try AVAudioPlayer(contentsOf: audioSi as URL)
             playerDoUp = try AVAudioPlayer(contentsOf: audioDoUp as URL)
         }
         catch{
             NSLog("fail")
         }
        myTableView.dataSource = self as UITableViewDataSource
        myTableView.delegate = self as UITableViewDelegate
    }
    
    func textFieldShouldReturn(_ defNameInput: UITextField) -> Bool {
        self.view.endEditing(true)//키보드에서 완성(return)을 누르면 키보드 내려감
        return true
    }
  
    @IBOutlet weak var defNameInput: UITextField!
    @IBAction func cancel(_ sender: Any) {
        fcurrentRow = 0
        dismiss(animated: true, completion: nil)
    }
    
    func Output_Alert(title : String, message : String, text : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: text, style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okButton)
        return self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func complete(_ sender: Any) {
        fcurrentRow = 0
        
        var loopNested:Bool = false
        var loopChecking:Int = 0

        for item in fitems{
            if item.isInt{
                loopChecking += 1
                if loopChecking>1{
                    loopNested = true
                }
            }else if item == "끝"{
                loopChecking -= 1
            }
        }
        
       if let data = defNameInput.text {
            if data.isInt{
                Output_Alert(title: "경고!", message: "함수 이름으로 숫자만 또는 한 글자만 입력하지 말아주세요(눈물)", text: "확인")
            }else if(loopChecking != 0){
                 Output_Alert(title: "경고!", message: "반복 시작점과 반복 끝점의 수가 안 맞아요. 확인해보셔요!", text: "확인")
            }else if loopNested{
                 Output_Alert(title: "경고!", message: "이중 반복문은 제작자의 역량 부족으로 흑흑 죄송합니다. 이중 반복 구조가 없도록 해주세요.", text: "확인")
            }
            else{
                delegate?.sendData(data: data, list: fitems)
                dismiss(animated: true, completion: nil)
            }
        }
    }

     @IBAction func `do`(_ sender: Any) {
        fitems.insert("도", at:fcurrentRow)
        play_stop(player: playerDo)
    }
    @IBAction func re(_ sender: Any) {
        fitems.insert("레", at:fcurrentRow)
        play_stop(player: playerRe)
    }
    @IBAction func mi(_ sender: Any) {
        fitems.insert("미", at:fcurrentRow)
        play_stop(player: playerMi)
    }
    @IBAction func fa(_ sender: Any) {
        fitems.insert("파", at:fcurrentRow)
        play_stop(player: playerFa)
    }
    @IBAction func sol(_ sender: Any) {
        fitems.insert("솔", at:fcurrentRow)
        play_stop(player: playerSol)
    }
    @IBAction func la(_ sender: Any) {
        fitems.insert("라", at:fcurrentRow)
        play_stop(player: playerLa)
    }
    @IBAction func si(_ sender: Any) {
        fitems.insert("시", at:fcurrentRow)
        play_stop(player: playerSi)
    }
    @IBAction func doUp(_ sender: Any) {
        fitems.insert("높은도", at:fcurrentRow)
        play_stop(player: playerDoUp)
    }
    @IBAction func pause(_ sender: Any) {
        fitems.insert("쉼표", at:fcurrentRow)
        self.myTableView.reloadData()
    }
    @IBAction func loopEnd(_ sender: Any) {
        fitems.insert("끝", at:fcurrentRow)
        myTableView.reloadData()
    }
    
    @IBAction func deleteNote(_ sender: Any) {
        if(fitems.count > 0 && fcurrentRow+1 < fitems.count){
            fitems.remove(at: fcurrentRow)
            AudioServicesPlaySystemSound(4095)
        }
         myTableView.reloadData()
    }
    @IBAction func ifSetting(_ sender: Any) {
       let alert = UIAlertController(title: "만약", message: "탈출하고 싶은 번째를 입력하세요", preferredStyle: .alert)
        alert.addTextField ()  {(myTextField) in
                myTextField.placeholder = "꼭 숫자로 입력해주세요"
        }

        let ok = UIAlertAction(title: "입력", style: .default) { (ok) in
            if (alert.textFields?[0].text?.isInt)!{
                let ifString:String = "만약\((alert.textFields?[0].text)!)"
                    fitems.insert(ifString, at:fcurrentRow)
                    fcurrentRow += 1
                    self.myTableView.reloadData()
                    
            }else{
                self.Output_Alert(title: "경고!", message: "숫자만 입력해주세요", text: "확인")
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancel) in
        }

        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func loopStart(_ sender: Any) {
        let alert = UIAlertController(title: "반복 지정", message: "반복 횟수를 입력하세요", preferredStyle: .alert)
        alert.addTextField ()  {(myTextField) in
                myTextField.placeholder = "꼭 숫자로 입력해주세요"
        }

        let ok = UIAlertAction(title: "입력", style: .default) { (ok) in
            if (alert.textFields?[0].text?.isInt)!{
                fitems.insert((alert.textFields?[0].text)!, at:fcurrentRow)
                 fcurrentRow += 1
                self.myTableView.reloadData()
            }else{
                 self.Output_Alert(title: "경고!", message: "숫자만 입력해주세요", text: "확인")
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (cancel) in
        }

        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func play_stop(player: AVAudioPlayer){//왜 이제야 생각난 것인가...
        player.play()
        usleep(UInt32(270000))
        player.currentTime = 0
        player.stop()
    }
    
    func playing(items:[String]){
      var startPoint = 6
        for i in 0..<items.count-1{
          if funcItems[items[i]] != nil{
              playing(items: funcItems[items[i]]!)
              continue
          }
            switch items[i].first{
                case "도": play_stop(player: playerDo)
                case "레": play_stop(player: playerRe)
                case "미": play_stop(player: playerMi)
                case "파": play_stop(player: playerFa)
                case "솔": play_stop(player: playerSol)
                case "라": play_stop(player: playerLa)
                case "시": play_stop(player: playerSi)
                case "높": play_stop(player: playerDoUp)
                case "쉼": usleep(UInt32(270000))
                case "끝":
                    for z in stride(from: i-1, to: -1, by: -1){
                        if(items[z].isInt){
                          startPoint = z
                            break
                        }
                    }
                BreakLoop:
                    for t in 1..<Int(items[startPoint])!{
                        for j in startPoint+1..<i {
                            switch items[j].first{
                                case "도": play_stop(player: playerDo)
                                case "레": play_stop(player: playerRe)
                                case "미": play_stop(player: playerMi)
                                case "파": play_stop(player: playerFa)
                                case "솔": play_stop(player: playerSol)
                                case "라": play_stop(player: playerLa)
                                case "시": play_stop(player: playerSi)
                                case "높": play_stop(player: playerDoUp)
                                case "쉼": usleep(UInt32(270000))
                                case "만":
                                    NSLog("fready")
                                    if( String(items[j].last!) == String(t+1)) {
                                        NSLog("ok")
                                        break BreakLoop
                                    }
                                default:
                                    NSLog("fzz")
                                  }
                                   NSLog("fwtf")
                               }
                           }
                default:
                    NSLog("fnothing")
                }
        NSLog("fcorrect")
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
          var loopNested:Bool = false
             var loopChecking:Int = 0

             for item in fitems{
                 if item.isInt{
                     loopChecking += 1
                     if loopChecking>1{
                         loopNested = true
                     }
                 }else if item == "끝"{
                     loopChecking -= 1
                 }
             }
             if(loopChecking != 0){
                  Output_Alert(title: "경고!", message: "반복 시작점과 반복 끝점의 수가 안 맞아요. 확인해보셔요!", text: "확인")
             }else if loopNested{
                  Output_Alert(title: "경고!", message: "이중 반복문은 제작자의 역량 부족으로 흑흑 죄송합니다. 이중 반복 구조가 없도록 해주세요.", text: "확인")
             }
             else {
                 playing(items: fitems)
                 }
    }
    
}



extension DefViewController: UITableViewDelegate,UITableViewDataSource{//, TableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return fitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SheetCell2", for: indexPath)
        cell.textLabel?.text = fitems[indexPath.row]
       
        return cell
    }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    fcurrentRow = indexPath.row
    NSLog("\(indexPath.row)번째 데이터가 클릭됨. \(fitems.count)")

  }
}

