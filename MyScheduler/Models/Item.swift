//
//  Item.swift
//  MyScheduler
//
//  Created by Takuya Nakajima on 2018/08/13.
//  Copyright © 2018 Takuya Nakajima. All rights reserved.
//

import RealmSwift

// Person model
class Item: Object {
    @objc dynamic var name = ""
    @objc dynamic var time : String?
}
