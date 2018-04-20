//
//  TestViewController.swift
//  ResultForTheTest
//
//  Created by Ryohei Nanano on 2018/04/18.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift//RxSwift使う為の準備
import RealmSwift//SwiftでRealm使う為の準備！

class TestViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!//得点が入力される
    @IBOutlet weak var hintLabel: UILabel!//入力された得点に応じてヒントを表示！
    @IBOutlet weak var countLabel: UILabel!
    
    var testScore: Int!//ランダム取得したテストの点数を入れておく為の変数
    var predictedScore: Int!//textFieldに入力された点数を入れておく為の変数
    var count: Int = 0//回答に要した回数を保持しておく為の変数
    
    let storyboardID = "ResultViewController"
    
    let realm = try! Realm()//Realmをインスタンス化→Realmのメソッドを使う準備が整った！
    let realmData = RealmData()//RealmDataをインスタンス化→変数realmDataに格納
    
    //=========ライフサイクル==========
    
    //Viewが作られた時に一度だけ呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Viewが表示される度に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        _init()//諸々初期化
    }
    
    
    
    
    //==========関数・メソッド==========
    
    //実際の点数と入力された値を比較→結果に応じて処理する関数
    @IBAction func check(){
        if(Int(textField.text!) != nil){//textFieldがnilでない時→なんらかの値が入力されている時
            count += 1//countに1を足す
            countLabel.text = String(count)
            predictedScore = Int(textField.text!)//textFieldの入力内容をInt型に変換して変数predictedScoreに格納
            
            if testScore < predictedScore {//実際の点数が予想よりも低い時
                hintLabel.text = "忘れたか？俺はバカだぜ？"
                adjustLabel(label: hintLabel)//hintLabelの表示を調整
            }
            else if testScore > predictedScore{//実際の点数が予想よりも高い時
                hintLabel.text = "おいおい。\n俺はイエスの生まれ変わりだぜ？"
                adjustLabel(label: hintLabel)//hintLabelの表示を調整
            }
            else{//予想が当たった時
                //Realmに値を保存
                try! realm.write {//Realmに値を書き込む準備
                    realmData.testScore = Int(textField.text!)!//weightに入力内容を代入
                    realmData.count = count//countの値をRealm上のcountに保持！
                    realm.add(realmData)//データ追加
                }
                
                //画面遷移のコード
                let storyboard = UIStoryboard(name: "Result", bundle: Bundle.main)//①先ずは遷移先のStoryboardを取ってくる
                let resultViewController = storyboard.instantiateViewController(withIdentifier: storyboardID)//②画面遷移先のViewControllerを取ってくる！
                navigationController?.pushViewController(resultViewController, animated: true)//取って来たViewControllerにpushで画面遷移！
            }
        }
        
    }
    
    //乱数を発生させて、Int型で返してくれるメソッドを定義
    func generateRandomNumber(max: UInt32, min: UInt32) -> Int {//maxからminの範囲の乱数をInt型で返してくれる
        return Int(arc4random_uniform(UInt32(max - min + 1)) + min)
    }
    
    //初期化する為の関数
    func _init(){
        testScore = generateRandomNumber(max: 100, min: 0)//0-100の範囲で乱数発生→変数testScoreに格納
        count = 0//countを0に戻す
        countLabel.text = String(count)
        hintLabel.text = "果たして当てられるかな..."
    }
    
    //Labelの調整を行う関数
    func adjustLabel(label: UILabel){
        label.numberOfLines = 0//折り返し
        label.sizeToFit()//文字数に応じてLabelの大きさを調整
        label.lineBreakMode = NSLineBreakMode.byCharWrapping //文字で改行
    }

}
