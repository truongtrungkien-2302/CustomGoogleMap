//
//  SimplePickerViewController.swift
//  AmisCRM
//
//  Created by DN on 3/8/19.
//  Copyright © 2019 MISA JSC. All rights reserved.
//

import UIKit
import Kingfisher

class SimplePickerObject: Comparable{
    static func < (lhs: SimplePickerObject, rhs: SimplePickerObject) -> Bool {
        return lhs.tag ?? 0 < rhs.tag ?? 0 && lhs.name < rhs.name
    }
    
    static func == (lhs: SimplePickerObject, rhs: SimplePickerObject) -> Bool {
        return lhs.tag == rhs.tag && lhs.name == rhs.name
    }
    
    var tag: Int?
    var obj: Any?
    var name: String!
    var id: Int?
    var text: Int?
    
    var imagePath: String?
    var image: UIImage?
    var isShowStatusView : Bool = false
    var statusColor : UIColor? = ThemeManager.color(style: .green)
    
    // GIANG PHAN BA R36 bộ lọc
    var defaultValue: String? // giá trị mặc định để map
    var defaultValue1: String? // giá trị mặc định để map
    var defaultValue2: String? // giá trị mặc định để map
    
    // Biến xem đối tượng có đang được selected hay không
    var isCheck: Bool = false
     func setIscheck(isCheck: Bool, maxSeries: inout Int) {
        self.isCheck = isCheck
        if isCheck == true {
            maxSeries += 1
            self.series = maxSeries
        } else {
            self.series = 0
        }
        
    }
    // Biến cho biết được  thứ tự của object
    var series: Int = 0
    init(name: String, obj: Any? = nil) {
        self.name = name
        self.obj = obj
    }
    
    init(name: String, obj: Any? = nil, image: UIImage?) {
        self.name = name
        self.obj = obj
        self.image = image
    }
    
    init(name: String, obj: Any? = nil, isCheck: Bool = false) {
        self.name = name
        self.obj = obj
        self.isCheck = isCheck
    }
    
    init(name: String, tag: Int? = nil, obj: Any? = nil, imagePath: String? = nil, isCheck: Bool = false, id: Int? = nil) {
        self.name = name
        self.obj = obj
        self.tag = tag
        self.imagePath = imagePath
        self.isCheck = isCheck
        self.id = id
    }
    
    init() {
    }
    
    static func convert(from stringList: [String]) -> [SimplePickerObject]{
        var result: [SimplePickerObject] = []
        for string in stringList {
            result.append(SimplePickerObject(name: string))
        }
        return result
    }
    
    static func none() -> SimplePickerObject{
        let noneObject = SimplePickerObject(name: "Common_None")
        noneObject.tag = -1
        return noneObject
    }
    
    ///  Khởi tạo danh sách mặc định, chỉ có hoặc không
    /// - Author: GIANG PHAN BA
    /// - Date: 20/05/2021

    static func initDataChooseDefault() -> [SimplePickerObject]{
        var lstData: [SimplePickerObject] = []
        let option1 = SimplePickerObject(name: "Common_Yes", obj: 1, isCheck: false)
        let option2 = SimplePickerObject(name: "Common_No", obj: 0, isCheck: false)
        lstData.append(option1)
        lstData.append(option2)
        return lstData
    }
    
    ///  Khởi tạo danh sách date măhc định
    /// - Author: GIANG PHAN BA
    /// - Date: 20/05/2021

    static func initDataDateDefault() -> [SimplePickerObject]{
        var lstData: [SimplePickerObject] = []
        let option1 = SimplePickerObject(name: "Choose_day", obj: 11, isCheck: false)
        let option2 = SimplePickerObject(name: "Common_Today", obj: 20, isCheck: false)
        let option3 = SimplePickerObject(name: "EReportPeriod_thisWeek", obj: 23, isCheck: false)
        let option4 = SimplePickerObject(name: "EReportPeriod_thisMonth", obj: 24, isCheck: false)
        let option5 = SimplePickerObject(name: "EReportPeriod_thisYear", obj: 25, isCheck: false)
        let option6 = SimplePickerObject(name: "EReportPeriod_yesterday", obj: 21, isCheck: false)
        let option7 = SimplePickerObject(name: "EReportPeriod_prevWeek", obj: 26, isCheck: false)
        let option8 = SimplePickerObject(name: "EReportPeriod_prevMonth", obj: 27, isCheck: false)
        let option9 = SimplePickerObject(name: "EReportPeriod_prevYear", obj: 28, isCheck: false)
        let option10 = SimplePickerObject(name: "Common_Tomorrow", obj: 22, isCheck: false)
        let option11 = SimplePickerObject(name: "EReportPeriod_nextWeek", obj: 32, isCheck: false)
        let option12 = SimplePickerObject(name: "EReportPeriod_nextMonth", obj: 33, isCheck: false)
        let option13 = SimplePickerObject(name: "EReportPeriod_nextYear", obj: 34, isCheck: false)
        let option14 = SimplePickerObject(name: "EReportPeriod_prevDay", obj: 17, isCheck: false)
        let option15 = SimplePickerObject(name: "EReportPeriod_nextDay", obj: 18, isCheck: false)
        let option16 = SimplePickerObject(name: "CRDVC_title", obj: 29, isCheck: false)
        let option17 = SimplePickerObject(name: "Empty", obj: 13, isCheck: false)
        let option18 = SimplePickerObject(name: "NotEmpty", obj: 14, isCheck: false)
        let option19 = SimplePickerObject(name: "This_Day_Every_Year", obj: 41, isCheck: false)
        let option20 = SimplePickerObject(name: "This_Week_Every_Year", obj: 42, isCheck: false)
        let option21 = SimplePickerObject(name: "This_Month_Every_Year", obj: 43, isCheck: false)
        let option22 = SimplePickerObject(name: "Range_In_Every_Year", obj:44, isCheck: false)
        let option23 = SimplePickerObject(name: "Period_X_Day", obj: 45, isCheck: false)
        let option24 = SimplePickerObject(name: "On_X_Day", obj: 146, isCheck: false)
        let option25 = SimplePickerObject(name: "Range_X_Day", obj: 47, isCheck: false)
        let option26 = SimplePickerObject(name: "Range_X_Next_Day", obj: 48, isCheck: false)
        let option27 = SimplePickerObject(name: "After_X_Nex_Day", obj: 49, isCheck: false)
        let option28 = SimplePickerObject(name: "On_X_Nex_Day", obj: 50, isCheck: false)
        lstData.append(option1)
        lstData.append(option2)
        lstData.append(option3)
        lstData.append(option4)
        lstData.append(option5)
        lstData.append(option6)
        lstData.append(option7)
        lstData.append(option8)
        lstData.append(option9)
        lstData.append(option10)
        lstData.append(option11)
        lstData.append(option12)
        lstData.append(option13)
        lstData.append(option14)
        lstData.append(option15)
        lstData.append(option16)
        lstData.append(option17)
        lstData.append(option18)
        lstData.append(option19)
        lstData.append(option20)
        lstData.append(option21)
        lstData.append(option22)
        lstData.append(option23)
        lstData.append(option24)
        lstData.append(option25)
        lstData.append(option26)
        lstData.append(option27)
        lstData.append(option28)
        
        return lstData
    }
    
    ///  khởi tạo danh sách chọn số mặc định
    /// - Author: GIANG PHAN BA
    /// - Date: 23/05/2021
    static func initDataNumberChooseDefault() -> [SimplePickerObject]{
        var lstData: [SimplePickerObject] = []
        let option1 = SimplePickerObject(name: "=", obj: 0, isCheck: false)
        let option2 = SimplePickerObject(name: "<>", obj: 9, isCheck: false)
        let option3 = SimplePickerObject(name: "<", obj: 3, isCheck: false)
        let option4 = SimplePickerObject(name: "<=", obj: 5, isCheck: false)
        let option5 = SimplePickerObject(name: ">", obj: 2, isCheck: false)
        let option6 = SimplePickerObject(name: ">=", obj: 4, isCheck: false)
        let option7 = SimplePickerObject(name: "CRDVC_title", obj: 29, isCheck: false)
        let option8 = SimplePickerObject(name: "OutOfRange", obj: 30, isCheck: false)
        let option9 = SimplePickerObject(name: "Empty", obj: 13, isCheck: false)
        let option10 = SimplePickerObject(name: "NotEmpty", obj: 14, isCheck: false)
        
        lstData.append(option1)
        lstData.append(option2)
        lstData.append(option3)
        lstData.append(option4)
        lstData.append(option5)
        lstData.append(option6)
        lstData.append(option7)
        lstData.append(option8)
        lstData.append(option9)
        lstData.append(option10)
        
        return lstData
    }
    
    ///  khởi tạo danh sách  để lọc mẫu (là, chứa, không chứa??)
    /// - Author: GIANG PHAN BA
    /// - Date: 07/03/2023
    static func initDataCompareDefault() -> [SimplePickerObject]{
        var lstData: [SimplePickerObject] = []
        let option1 = SimplePickerObject(name: "Là", obj: 11, isCheck: false)
        let option2 = SimplePickerObject(name: "Không là", obj: 12, isCheck: false)
        let option3 = SimplePickerObject(name: "Trống", obj: 13, isCheck: false)
        let option4 = SimplePickerObject(name: "Không trống", obj: 14, isCheck: false)
        let option5 = SimplePickerObject(name: "Chứa", obj: 1, isCheck: false)
        let option6 = SimplePickerObject(name: "Không chứa", obj: 8, isCheck: false)
        lstData.append(option1)
        lstData.append(option2)
        lstData.append(option3)
        lstData.append(option4)
        lstData.append(option5)
        lstData.append(option6)
        return lstData
    }
}
