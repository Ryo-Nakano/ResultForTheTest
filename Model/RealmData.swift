//
//  RealmData.swift
//  ResultForTheTest
//
//  Created by Ryohei Nanano on 2018/04/20.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import RealmSwift//SwiftでRealm使う為の準備！

class RealmData: Object {//RealmではObject型でデータを保存する！
    
    @objc dynamic var testScore: Int = 0//初期値として0入れておく
    @objc dynamic var count: Int = 0//初期値として0入れておく
    
    //後からRealmに要素追加とかをする時は『マイグレーション処理』を行わないといけない！
    //要は勝手に後から要素追加はできないよって話！
    
    //    //プライマリーキーの設定
    //    override static func primaryKey() -> String? {
    //        return "realmId"
    //    }
}
