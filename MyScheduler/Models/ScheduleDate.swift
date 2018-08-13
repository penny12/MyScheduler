//
//  Date.swift
//  MyScheduler
//
//  Created by Takuya Nakajima on 2018/08/13.
//  Copyright © 2018 Takuya Nakajima. All rights reserved.
//

import RealmSwift

// ScheduleDate model
class ScheduleDate: Object {
    @objc dynamic var date : String?
    let items = List<Item>()
}
