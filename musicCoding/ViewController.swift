//
//  ViewController.swift
//  test10
//
//  Created by 김도연 on 25/01/2020.
//  Copyright © 2020 김도연. All rights reserved.
//


import UIKit
import AudioKit
import AVFoundation


var items: [String] = ["도","레","만약2","미","파","끝",
    "지워지지 않아요"]
var funcItems:[String:[String]] = [:]

var currentRow:Int = 0 // 눈물 좔좔

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
    var isString:Bool{
        return String(self) != nil
    }
}

class ViewController: UIViewController,SendDataDelegate{
    func sendData(data:  String, list:[String]) {
        funcItems[data] = list
    }
    
    func Output_Alert(title : String, message : String, text : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: text, style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okButton)
        return self.present(alertController, animated: true, completion: nil)
    }

   
    
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
          currentRow += 1
      }
    
    // MARK: ViewController override method
  override func viewDidLoad() {
    super.viewDidLoad()
    //버튼
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
    
    myTableView.dataSource = self
    myTableView.delegate = self as UITableViewDelegate
    
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "defSegue" {
            let viewController : DefViewController = segue.destination as! DefViewController
            viewController.delegate = self
        }
    }
     @IBAction func `do`(_ sender: Any) {
           items.insert("도", at:currentRow)
          play_stop(player: playerDo)
       }
    @IBAction func re(_ sender: Any) {
         items.insert("레", at:currentRow)
        play_stop(player: playerRe)
    }
    @IBAction func mi(_ sender: Any) {
         items.insert("미", at:currentRow)
        play_stop(player: playerMi)
    }
    @IBAction func fa(_ sender: Any) {
        items.insert("파", at:currentRow)
        play_stop(player: playerFa)
    }
    @IBAction func sol(_ sender: Any) {
        items.insert("솔", at:currentRow)
        play_stop(player: playerSol)
    }
    @IBAction func la(_ sender: Any) {
        items.insert("라", at:currentRow)
        play_stop(player: playerLa)
    }
    @IBAction func si(_ sender: Any) {
        items.insert("시", at:currentRow)
        play_stop(player: playerSi)
    }
    @IBAction func doUp(_ sender: Any) {
        items.insert("높은도", at:currentRow)
        play_stop(player: playerDoUp)
    }
    
    @IBAction func pause(_ sender: Any) {
        items.insert("쉼표", at:currentRow)
        self.myTableView.reloadData()
    }
    @IBAction func loopEnd(_ sender: Any) {
         items.insert("끝", at:currentRow)
         myTableView.reloadData()
    }
    @IBAction func deleteNote(_ sender: Any) {
        if(items.count > 0 && currentRow+1 < items.count){
            items.remove(at: currentRow)
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
                    items.insert(ifString, at:currentRow)
                    currentRow += 1
                    self.myTableView.reloadData()
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
                items.insert((alert.textFields?[0].text)!, at:currentRow)
                currentRow += 1
                self.myTableView.reloadData()
            }
        }
        let cancel = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in
        }

        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func myExit(sender:UIStoryboardSegue){
    }

    @IBAction func funcList(_ sender: Any) {
        NSLog("\(funcItems)")
        let actionSheet = UIAlertController(title: "함수 목록", message: "'함수 생성' 버튼에서 만든 함수 중 원하는 함수를 선택하면 해당 위치에 함수가 들어갑니다. '함수'란 다시 쓰기 편하게 여러 줄을 묶어서 쓸 수 있도록 하는 거예요.", preferredStyle: .actionSheet)
        for (key,_) in funcItems {
            actionSheet.addAction(UIAlertAction(title: key, style: .default, handler: { result in //doSomething
                items.insert(key, at: currentRow)
                currentRow += 1
                self.myTableView.reloadData()
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    func play_stop(player: AVAudioPlayer){//왜 이제야 생각난 것인가...
        player.play()
        usleep(UInt32(270000))
        player.stop()
        player.currentTime=0
    }
    func playing(items:[String]){
        var startPoint = 3
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
                            if funcItems[items[j]] != nil{
                                playing(items: funcItems[items[j]]!)
                                continue
                            }
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

        for item in items{
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
             Output_Alert(title: "경고!", message: "반복 시작점의 수와 반복 끝점의 수가 안 맞아요. 확인해주세요!", text: "확인")
        }else if loopNested{
             Output_Alert(title: "경고!", message: "이중 반복문은 제작자의 역량 부족으로 흑흑 죄송합니다. 이중 반복 구조가 없도록 해주세요.", text: "확인")
        }
        else {
            playing(items: items)
            }

    }
    
}


// MARK: UITableViewDelegate
//테이블에서 발생하는 액션/이벤트와 관련된 메소드 정의
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        NSLog("\(indexPath.row)번째 데이터가 클릭됨. \(items.count)")

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return items.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SheetCell", for: indexPath)
           cell.textLabel?.text = items[indexPath.row]
          
           return cell
    }
}

