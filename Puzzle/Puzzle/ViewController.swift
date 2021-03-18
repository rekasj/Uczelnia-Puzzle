//
//  ViewController.swift
//  Puzzle
//
//  Created by Jakub Rękas on 13/01/2021.
//

import UIKit




//Tablica poprawnej konfiguracji


class ViewController: UIViewController {

   
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn0: UIButton!
    
    @IBOutlet weak var startBtn: UIButton!

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var winLbl: UILabel!
    
    
    
    
    let gitArray = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3"),
        UIImage(named: "4"),
        UIImage(named: "5"),
        UIImage(named: "6"),
        UIImage(named: "7"),
        UIImage(named: "8"),
        UIImage(named: "0")
    ]
    var btnArray = [UIButton]()
    var check: Int = 0
    var x: UIImage = UIImage(named: "0")!
    var y: UIImage = UIImage(named: "0")!
    var r: Int = 0
    var nums = [0,1,2,3,4,5,6,7,8]
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnArray = [
            btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn0
        ]
        startBtn.layer.cornerRadius = 16;
        
        for i in 0...8
        {
            r = nums.randomElement()!
            btnArray[i].setImage(gitArray[r], for: .normal)
            nums.removeAll { $0 == r }
        }
        
    }
    @IBAction func btnPressed(_ sender: UIButton)
    {
        if(sender.tag != 0)
        {
            let image = sender.currentImage!
            for i in 0...8
            {
                let a = btnArray[i].tag
                let b = sender.tag
                y = btnArray[i].currentImage!
                if  (y == x && (a-b==1 || a-b==3 || b-a==1 || b-a==3))
                {
                    sender.setImage(UIImage(named: "0"), for: .normal)
                    btnArray[i].setImage(image, for: .normal)
                }
                if(btnArray[i].currentImage! == gitArray[i])
                {
                    check += 1
                }
                else
                {
                    check = 0
                }
                
            }
        }
        if(check == 8)
        {
            timer.invalidate()
            winLbl.text = "WYGRAŁEŚ"
            winLbl.backgroundColor =  #colorLiteral(red: 0, green: 0.8095313907, blue: 0.6680155396, alpha: 1)
        }
        
    }
    @IBAction func startPressed(_ sender: UIButton)
    {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            for i in btnArray
            {
                i.isEnabled = false
            }
            startBtn.setTitle("START", for: .normal)
            
        }
        else
        {
            timerCounting = true
            for i in btnArray
            {
                i.isEnabled = true
            }
            startBtn.setTitle("STOP", for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
            
        }
        
        
    }
    
    @objc func timerCounter() -> Void
    {
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timeLbl.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "0%2d", hours)
        timeString += " : "
        timeString += String(format: "0%2d", minutes)
        timeString += " : "
        timeString += String(format: "0%2d", seconds)
        return timeString
    }
    
}


