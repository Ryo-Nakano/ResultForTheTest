//
//  ResultViewController.swift
//  ResultForTheTest
//
//  Created by Ryohei Nanano on 2018/04/18.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import RealmSwift

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var testScoreLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var testScore: Int = 0
    var count: Int = 0
    
    let realm = try! Realm()//Realmをインスタンス化→変数realmに格納
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //①先ずはRealm上から保存してあるObject取ってくる
        let results = realm.objects(RealmData.self)//Realm上に保存してある値を取って来て、取り敢えず全部resultsにぶち込む
        
        if let testScore = (results.last?.testScore){
            testScoreLabel.text = String(testScore)
        }
        if let count = (results.last?.count){
            countLabel.text = String(count)
        }
        
        
    }

    
    

    
}
