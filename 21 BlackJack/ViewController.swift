//
//  ViewController.swift
//  21 BlackJack
//
//  Created by Nicholas Wylynko (Y9) on 12/10/18.
//  Copyright © 2018 Nicholas Wylynko (Y9). All rights reserved.
//


import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    
    let deck = ["Hearts01","Hearts02","Hearts03","Hearts04","Hearts05","Hearts06","Hearts07","Hearts08","Hearts09","Hearts10","Hearts11","Hearts12","Hearts13","Diamonds01","Diamonds02","Diamonds03","Diamonds04","Diamonds05","Diamonds06","Diamonds07","Diamonds08","Diamonds09","Diamonds10","Diamonds11","Diamonds12","Diamonds13","Spades01","Spades02","Spades03","Spades04","Spades05","Spades06","Spades07","Spades08","Spades09","Spades10","Spades11","Spades12","Spades13","Clubs01","Clubs02","Clubs03","Clubs04","Clubs05","Clubs06","Clubs07","Clubs08","Clubs09","Clubs10","Clubs11","Clubs12","Clubs13"]
    
    let DS = ["Hearts01" : 11 ,"Hearts02" : 2 ,"Hearts03" : 3 ,"Hearts04" : 4 ,"Hearts05" : 5 ,"Hearts06" : 6 ,"Hearts07" : 7 ,"Hearts08" : 8 ,"Hearts09" : 9 ,"Hearts10" : 10 ,"Hearts11" : 10 ,"Hearts12" : 10 ,"Hearts13" : 10 ,"Diamonds01" : 11 ,"Diamonds02" : 2 ,"Diamonds03" : 3 ,"Diamonds04" : 4 ,"Diamonds05" : 5 ,"Diamonds06" : 6 ,"Diamonds07" : 7 ,"Diamonds08" : 8 ,"Diamonds09" : 9 ,"Diamonds10" : 10 ,"Diamonds11" : 10 ,"Diamonds12" : 10 ,"Diamonds13" : 10 ,"Spades01" : 11 ,"Spades02" : 2 ,"Spades03" : 3 ,"Spades04" : 4 ,"Spades05" : 5 ,"Spades06" : 6,"Spades07" : 7 ,"Spades08" : 8 ,"Spades09" : 9 ,"Spades10" : 10 ,"Spades11" : 10 ,"Spades12" : 10 ,"Spades13" : 10 ,"Clubs01" : 11 ,"Clubs02" : 2 ,"Clubs03" : 3 ,"Clubs04" : 4 ,"Clubs05" : 5 ,"Clubs06" : 6 ,"Clubs07" : 7 ,"Clubs08" : 8 ,"Clubs09" : 9 ,"Clubs10" : 10 ,"Clubs11" : 10 ,"Clubs12" : 10 ,"Clubs13" : 10]
    
    let dealer = UIView()
    let player = UIView()
    let betting = UIView()
    var dealerScore = 0
    var playerScore = 0
    var playerHand = [String]()
    var dealerHand = [String]()
    
    let cards = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    
    let buttons = [UIButton(type: UIButtonType.system), UIButton(type: UIButtonType.system), UIButton(type: UIButtonType.system), UIButton(type: UIButtonType.system), UIButton(type: UIButtonType.system), UIButton(type: UIButtonType.system), UIButton(type: UIButtonType.system)]
    
    let scoreLabels = [UILabel(), UILabel(), UILabel(), UILabel(), UILabel()]
    let staticLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    var money = 100
    var bet = 0
    
    func createStaticLabels(list: Int, text: String, x: Int, y: Int){
        staticLabels[list].frame = CGRect(x: x, y: y, width: 100, height: 50)
        //staticLabels[list].backgroundColor = UIColor.red
        //staticLabels[list].layer.cornerRadius = 10
        staticLabels[list].textAlignment = NSTextAlignment.center
        staticLabels[list].font = UIFont.boldSystemFont(ofSize: 15)
        staticLabels[list].text = text
        self.view.addSubview(staticLabels[list])
    }
    
    
    func changeCard(list: Int, cardto: String) {
        UIView.transition(with: cards[list],
                          duration: 0.75,
                          options: .transitionCrossDissolve,
                          animations: { self.cards[list].image = UIImage(named: cardto) },
                          completion: nil)
    }
    
    func createBettingUI() {
        betting.frame = CGRect(x: 450,y: 375,width: 300, height: 100)
        betting.backgroundColor=UIColor.red
        betting.layer.cornerRadius=25
        betting.layer.borderWidth=0
        self.view.addSubview(betting)
    }
    
    func createBets(list: Int, x: Int, y: Int, amount: String){
        
        
        buttons[list].backgroundColor = UIColor.red
        buttons[list].layer.cornerRadius = 10
        buttons[list].titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttons[list].setTitleColor(UIColor.black, for: UIControlState.normal)
        
        buttons[list].frame = CGRect(x: x,y: y,width: 50, height: 100)
        buttons[list].setTitle(amount, for: UIControlState.normal)
        
        switch amount {
        case "+1":
            buttons[list].addTarget(self, action:#selector(betAmountAdd1), for: UIControlEvents.touchUpInside)
        case "+10":
            buttons[list].addTarget(self, action:#selector(betAmountAdd10), for: UIControlEvents.touchUpInside)
        case "-1":
            buttons[list].addTarget(self, action:#selector(betAmountRemove1), for: UIControlEvents.touchUpInside)
        case "-10":
            buttons[list].addTarget(self, action:#selector(betAmountRemove10), for: UIControlEvents.touchUpInside)
        default:
            print("error")
        }
        
        self.view.addSubview(buttons[list])
        
    }
    
    func betAmountAdd1(){
        if money >= 1 {
            money = money - 1
            bet = bet + 1
            scoreLabels[2].text = String(money)
            scoreLabels[3].text = String(bet)
        }
        scoreLabels[4].removeFromSuperview()
    }
    func betAmountAdd10(){
        if money >= 10 {
            money = money - 10
            bet = bet + 10
            scoreLabels[2].text = String(money)
            scoreLabels[3].text = String(bet)
        }
        scoreLabels[4].removeFromSuperview()
    }
    func betAmountRemove1(){
        if bet >= 1 {
            money = money + 1
            bet = bet - 1
            scoreLabels[2].text = String(money)
            scoreLabels[3].text = String(bet)
        }
        scoreLabels[4].removeFromSuperview()
    }
    func betAmountRemove10(){
        if bet >= 10 {
            money = money + 10
            bet = bet - 10
            scoreLabels[2].text = String(money)
            scoreLabels[3].text = String(bet)
        }
        scoreLabels[4].removeFromSuperview()
    }
    
    func deckScore(card: String) -> Int{
        return(DS[card]!)
    }
    
    func createHands(hand: UIView, y: Int){
        
        hand.frame = CGRect(x: 10,y: y+20,width: 750, height: 310)
        hand.backgroundColor=UIColor.red
        hand.layer.cornerRadius=25
        hand.layer.borderWidth=0
        self.view.addSubview(hand)
    
    }
    
    func createCards(){
        
        for i in 0...6 {
            cards[i].frame = CGRect(x: 30+(85*i), y: 40, width: 192, height: 270)
        }
        var n = 0
        for i in 7...13 {
            
            cards[i].frame = CGRect(x: 30+(85*n), y: 540, width: 192, height: 270)
            n += 1
        }

        for i in 0...13 {
            cards[i].image = UIImage(named: "card_back")
            self.view.addSubview(cards[i])
        }
        
    }
    
    func createUILabels (list: Int, x: Int, y: Int, width: Int, height: Int, text: String) {
        scoreLabels[list].frame = CGRect(x: x, y: y, width: width, height: height)
        scoreLabels[list].backgroundColor = UIColor.red
        scoreLabels[list].layer.cornerRadius = 10
        scoreLabels[list].textAlignment = NSTextAlignment.center
        scoreLabels[list].font = UIFont.boldSystemFont(ofSize: 30)
        scoreLabels[list].text = text
        self.view.addSubview(scoreLabels[list])
    
        
    }
    
    func createButtons(list: Int, title: String, x: Int, y: Int, funcAction: String){
        
        
        buttons[list].backgroundColor = UIColor.red
        buttons[list].layer.cornerRadius = 10
        buttons[list].titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        buttons[list].setTitleColor(UIColor.black, for: UIControlState.normal)

        buttons[list].frame = CGRect(x: x,y: y,width: 200, height: 100)
        buttons[list].setTitle(title, for: UIControlState.normal)
        
        switch funcAction {
        case "startButtonAction":
            buttons[list].addTarget(self, action:#selector(startButtonAction), for: UIControlEvents.touchUpInside)
        case "hitMeButtonAction":
            buttons[list].addTarget(self, action:#selector(hitMeButtonAction), for: UIControlEvents.touchUpInside)
        case "holdButtonAction":
            buttons[list].addTarget(self, action:#selector(holdButtonAction), for: UIControlEvents.touchUpInside)
        default:
            print("error")
        }
        

        self.view.addSubview(buttons[list])

        
    }
    
    func startButtonAction() {
        print("start")
        
        dealerScore = 0
        playerScore = 0
        playerHand = [String]()
        dealerHand = [String]()
        scoreLabels[2].text = String(money)
        scoreLabels[3].text = String(bet)
        
        for i in 0...13{
            changeCard(list: i, cardto: "card_back")
            //cards[i].image = UIImage(named: "card_back")
        }
        
        createButtons(list: 1, title: "Hit Me", x: 50, y: 875, funcAction: "hitMeButtonAction")
        createButtons(list: 2, title: "Hold", x: 500, y: 875, funcAction: "holdButtonAction")
        createUILabels(list: 0, x: 325, y: 375, width: 100, height: 100, text: "0")
        createUILabels(list: 1, x: 325, y: 875, width: 100, height: 100, text: "0")
        
        buttons[0].removeFromSuperview()
        for i in 3...6{
            buttons[i].removeFromSuperview()
        }
        
        //shuffle the deck using GameplayKit
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: deck)
        
        //create a blank array of strings
        var newDeck = [String]()
        
        //append the items from the shuffled deck and force them to become Strings (they were Objects)
        for item in shuffledDeck{
            newDeck.append(item as! String)
        }
        
        
        
        for _ in 0...6{
            playerHand.append(newDeck.removeFirst())
        }
        
        for _ in 0...6{
            dealerHand.append(newDeck.removeFirst())
        }
        
        print(playerHand)
        print(dealerHand)
        
        changeCard(list: 0, cardto: String(dealerHand[0]))
        dealerScore += deckScore(card: dealerHand[0])
        changeCard(list: 7, cardto: String(playerHand[0]))
        playerScore += deckScore(card: playerHand[0])
        changeCard(list: 8, cardto: String(playerHand[1]))
        playerScore += deckScore(card: playerHand[1])
        
        scoreLabels[0].text = String(dealerScore)
        scoreLabels[1].text = String(playerScore)
        
    }
    func hitMeButtonAction() {
        var cardPlace = 0
        for i in 7...13{
            if cards[i].image != UIImage(named: "card_back"){
                cardPlace += 1
            }
        }
        print(cardPlace)
        
        //cards[cardPlace + 7].image = UIImage(named: playerHand[cardPlace])
        changeCard(list: (cardPlace + 7), cardto: String(playerHand[cardPlace]))
        if deckScore(card: playerHand[cardPlace]) == 11{
            if playerScore < 10{
                playerScore += 11
            }
            else {
                playerScore += 1
            }
        }
        else{
            playerScore += deckScore(card: playerHand[cardPlace])
        }
        scoreLabels[1].text = String(playerScore)
        checkplayerScore()
        
    }
    
        
    func holdButtonAction() {
        buttons[1].removeFromSuperview()
        buttons[2].removeFromSuperview()
        
        checkdealerScore()
        
        //dealers turn
        
        
        for i in 0...6{
            if cards[i].image == UIImage(named: "card_back"){
                if dealerScore <= playerScore {
                    changeCard(list: i, cardto: String(dealerHand[i]))
                    //cards[i].image = UIImage(named: dealerHand[i])
                    dealerScore += deckScore(card: dealerHand[i])
                    scoreLabels[0].text = String(dealerScore)
                    checkdealerScore()
                }
            }
        }
    }
    
    func checkplayerScore(){
        if playerScore > 21 {
            lostGame()
        }
        if cards[13].image != UIImage(named: "card_back"){
            if playerScore < 21 {
                wonGame()
            }
        }
    }
    
    func restartGameMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let action = UIAlertAction(title:"OK", style:.default, handler:nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        createButtons(list: 0, title: "Start", x: 50, y: 375, funcAction: "startButtonAction")
        buttons[1].removeFromSuperview()
        buttons[2].removeFromSuperview()
    }
    
    func checkdealerScore(){
        if dealerScore > 21 {
            if playerScore <= 21 {
                wonGame()
            }
        }
        if dealerScore == 21{
            if playerScore == 21{
                lostGame()
            }
        }
        if dealerScore > playerScore{
            lostGame()
        }
    }
    
    func wonGame(){
        money = money + (bet*2)
        restartGameMessage(title: "You Win", message: "Play Again")
        scoreLabels[2].text = String(money)
        scoreLabels[3].text = String(bet)
        for i in 3...6{
            self.view.addSubview(buttons[i])
        }
    }
    
    func lostGame(){
        bet = 0
        restartGameMessage(title: "You Lost", message: "Try again?")
        scoreLabels[2].text = String(money)
        scoreLabels[3].text = String(bet)
        for i in 3...6{
            self.view.addSubview(buttons[i])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createHands(hand: dealer, y: 0)
        createHands(hand: player, y: 500)
        createCards()
        createButtons(list: 0, title: "Start", x: 50, y: 375, funcAction: "startButtonAction")
        createBettingUI()
        createUILabels(list: 2, x: 550, y: 375, width: 100, height: 50, text: "0")
        createUILabels(list: 3, x: 550, y: 425, width: 100, height: 50, text: "0")
        createBets(list: 3, x: 500, y: 375, amount: "+1")
        createBets(list: 4, x: 450, y: 375, amount: "+10")
        createBets(list: 5, x: 650, y: 375, amount: "-1")
        createBets(list: 6, x: 700, y: 375, amount: "-10")
        scoreLabels[2].text = String(money)
        scoreLabels[3].text = String(bet)
        createStaticLabels(list: 0, text: "Dealer", x: 325, y: 10)
        createStaticLabels(list: 1, text: "Hand", x: 325, y: 510)
        createStaticLabels(list: 2, text: "Money", x: 550, y: 355)
        createStaticLabels(list: 3, text: "Bet", x: 550, y: 405)
        createUILabels(list: 4, x: 50, y: 375, width: 200, height: 100, text: "Bet First ->")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

