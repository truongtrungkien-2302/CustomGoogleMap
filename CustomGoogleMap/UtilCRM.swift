//
//  UtilCRM.swift
//  AmisCRM
//
//  Created by Phung Ngoc Hue on 3/7/19.
//  Copyright © 2019 MISA JSC. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import Photos
//import Permission
import MessageUI

extension UUID {
    static func `default`() -> String{
        return UUID().uuidString
    }
}

extension Int64 {
    /// Hàm lấy ra thông tin dung lượng ảnh - Dùng để hiển thị
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 10/04/2019
    public func displayFileSize() -> String{
        
        var displaySize = ""
        if self > 1024*1024*1024 {
            let mb = Double(self) / (1024*1024.0*1024.0)
            displaySize = String(format: "%.02f GB", mb)
        }else if self > 1024*1024 {
            let mb = Double(self) / (1024.0*1024.0)
            displaySize = String(format: "%.02f MB", mb)
        }else{
            let kb = Double(self) / (1024.0)
            displaySize = String(format: "%.02f KB", kb)
        }
        return displaySize
    }
}

extension Int {
    /// Hàm lấy ra thông tin dung lượng ảnh - Dùng để hiển thị
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 10/04/2019
    public func displayFileSize() -> String{
        
        var displaySize = ""
        if self > 1024*1024 {
            let mb = Double(self) / (1024.0*1024.0)
            displaySize = String(format: "%.02f MB", mb)
        }else{
            let kb = Double(self) / (1024.0)
            displaySize = String(format: "%.02f KB", kb)
        }
        return displaySize
    }
}

class UtilCRM {
    
    static func sendEmail( mes: String){
//        if MFMailComposeViewController.canSendMail() {
//                           let mail = MFMailComposeViewController()
//                            mail.mailComposeDelegate = UIApplication.topViewController() as? MFMailComposeViewControllerDelegate
//                           mail.setToRecipients(["taigc00760@gmail.com"])
//                           mail.setSubject("Loi dang nhap ====LỖI")
//                           mail.setMessageBody(mes, isHTML: true)
//                           UIApplication.topViewController()?.present(mail, animated: true, completion: nil)
//                       } else {
//                           print("Application is not able to send an email")
//                       }
    }
    
    
    
    
//    static func sendEmailError(){
//        if MFMailComposeViewController.canSendMail() {
//            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let file = "errorFile.txt"
//                let fileURL = dir.appendingPathComponent(file)
//                let mail = MFMailComposeViewController()
//                mail.mailComposeDelegate = UIApplication.topViewController() as? MFMailComposeViewControllerDelegate
//                mail.setToRecipients(["misalogger@gmail.com"])
//                mail.setSubject("THÔNG TIN LỖI ỨNG DỤNG CRM IOS  ")
//                mail.setMessageBody("Thông thiết bị:\n \(DeviceUtils.name) - \(DeviceUtils.systemVersion)\n Phiên bản :\(DeviceUtils.versionShortBundleApp())", isHTML: true)
//                if let fileData = NSData(contentsOfFile: fileURL.path)
//                {
//                    print("File data loaded.")
//                    mail.addAttachmentData(fileData as Data, mimeType: "text/txt", fileName: "errorFile.txt")
//                }
//                
//                //this will compose and present mail to user
//                UIApplication.topViewController()?.present(mail, animated: true, completion: nil)
//            } else {
//                print("Application is not able to send an email")
//            }
//        }
//            
//            
//        
//    }
    
    /*
     Lấy URL ảnh stringee
     
     - Author: chu cuong
     - Date: 26/6/2021
     */
    @objc static func avatarURLStringee( _ url: String) -> NSURL? {
      //  let str = url.replacing(pattern: "apidemo.amis.vn", withTemplate: "api.amis.vn")
        guard let url = NSURL(string: url) else {
            return nil
        }
        
        return url
    }
    /**
     chuyển xử lý về main queue
     - parametes:
     - closure: Xử lý
     - author: ntliem
     - Date: 19/11/2018
     */
    @objc static func mainQueue(_ closure: @escaping ()->()){
        DispatchQueue.main.async {
            closure()
        }
    }
    
    //MARK: Stringee
    /*
     LẤy ra dối tượng chat stringee
     
     - Author: chu cuong
     - Date: 26/6/2021
     */
//    static func getEmployeeFromStringee(_ phoneNUmber: String,_ module : EModule? , complete: @escaping(_ employee: UserInfoObejct) -> Void){
//        let phoneFormat = PhoneNumberBusiness.getPhoneNumber84To0(phoneNumber: phoneNUmber, region: ServerConfig.phoneNumberConutryCode)
//        var param : [ParamServerGetList] = []
//        let paramObjectOne = ParamServerGetList()
//        paramObjectOne.columns = "SUQsQWNjb3VudE5hbWUsQXN5bmNJRCxPcmdhbml6YXRpb25Vbml0SURUZXh0"
//        paramObjectOne.page = 1
//        paramObjectOne.layoutCode = EModule.account.rawValue
//        paramObjectOne.start = 0
//        paramObjectOne.sorts = []
//        paramObjectOne.pageSize = 1000
//        paramObjectOne.isUsedELTS = true
//        
//        
//       
//        
//        let filter = ParamFiltersList()
//        filter._operator = 1
//        filter.property = "OfficeTel"
//        filter.addition = 2
//        filter.inputType = EControlType.oneLine
//        filter.value = phoneFormat
//        paramObjectOne.filters = [filter]
//       
//       
//        
//        
//        let paramObjectTwo = ParamServerGetList()
//        paramObjectTwo.columns = "SUQsQWNjb3VudE5hbWUsQXN5bmNJRCxPcmdhbml6YXRpb25Vbml0SURUZXh0"
//        paramObjectTwo.page = 1
//        paramObjectTwo.layoutCode = EModule.contact.rawValue
//        paramObjectTwo.start = 0
//        paramObjectTwo.sorts = []
//        paramObjectTwo.pageSize = 1000
//        paramObjectTwo.isUsedELTS = true
//        let filterMobile = ParamFiltersList()
//        filterMobile._operator = 1
//        filterMobile.property = "Mobile"
//        filterMobile.addition = 2
//        filterMobile.inputType = EControlType.oneLine
//        filterMobile.value = phoneFormat
//        
//        let filterOfficeTel = ParamFiltersList()
//        filterOfficeTel._operator = 1
//        filterOfficeTel.property = "OfficeTel"
//        filterOfficeTel.addition = 2
//        filterOfficeTel.inputType = EControlType.oneLine
//        filterOfficeTel.value = phoneFormat
//        
//        let filterOtherPhone = ParamFiltersList()
//        filterOtherPhone._operator = 1
//        filterOtherPhone.property = "OtherPhone"
//        filterOtherPhone.addition = 2
//        filterOtherPhone.inputType = EControlType.oneLine
//        filterOtherPhone.value = phoneFormat
//        paramObjectTwo.filters = [filterMobile, filterOfficeTel,filterOtherPhone]
//       
//        
//        
//        
//        let paramObjectThree = ParamServerGetList()
//        paramObjectThree.columns = "SUQsQWNjb3VudE5hbWUsQXN5bmNJRCxPcmdhbml6YXRpb25Vbml0SURUZXh0"
//        paramObjectThree.page = 1
//        paramObjectThree.layoutCode = EModule.lead.rawValue
//        paramObjectThree.start = 0
//        paramObjectThree.sorts = []
//        paramObjectThree.pageSize = 1000
//        paramObjectThree.isUsedELTS = true
//        paramObjectThree.filters = [filterMobile, filterOfficeTel,filterOtherPhone]
//        
//        
//        if module == EModule.lead {
//            param.append(paramObjectThree)
//        }else if module == EModule.contact{
//            param.append(paramObjectTwo)
//        }else if module == EModule.account{
//            param.append(paramObjectOne)
//        }else if module == nil {
//            param.append(paramObjectOne)
//            param.append(paramObjectTwo)
//            param.append(paramObjectThree)
//        }
//        
//
//            if Network.isLostConnection(showToast: true) {
//                return
//            }
//            CommonService()
//                .onCompletionAll({(success, response, error) in
//                    if let response = response as? UserInfoObejct {
//                        complete(response)
//                    }else{
//                        complete(UserInfoObejct())
//                    }
//                })
//                .getUserByPhoneNumber(param: param)
//        
//    }
    
    /*
     Kiểm tra quyền micro
     
     - Author: chu cuong
     - Date: 26/6/2021
     */
//    @objc static func checkMicroPermission() -> Bool{
//        switch AVAudioSession.sharedInstance().recordPermission {
//        case .denied:
////            AlertViewHelper.showConfirmAlertView(delegate: self.topViewController(), title: "AMIS", message: "common_permission_micro".localize, onOk: { (a) in
////                if let url = URL(string: UIApplication.openSettingsURLString){
////                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
////                }
////            }, onCancel: nil)
//     
//            UIAlertController.showConfirmAlertView(delegate: UIApplication.topViewController() ?? UIViewController() ,title: LocalizeHelper.getStringForKey("AMIS"), message: LocalizeHelper.getStringForKey("OSCCT_ConfirmAddContact"), onOk: { (action: UIAlertAction) in
//                if let url = URL(string: UIApplication.openSettingsURLString){
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
//            }, onCancel: nil)
//
//            
//            
//            return false
//        default:
//            return true
//        }
//    }
    /**
     Post delay
     - parametes:
     - delay: Thời gian delay
     - closure: Xử lý sau khi delay
     - author: ntliem
     - Date: 09/02/2017
     */
    @objc static func delay(_ delay: Double = 0.5, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
    // Gii nén data thành đối tượng ban đầu
    class func unarchive (data: Data) -> Any? {
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
    
    // Chuyển đối tượng thành dạng nén
    class func archive (object: Any, key: String) -> Data {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        return data
    }

    
    /*----------------------------------------------------------------------------*/
    ///   Kiểm tra xem any có bằng nil không
    /// - Author: Phùng Ngọc Huề
    /// - Date: 21/8/2019
    static public func isAnyNil(_ any: Any) -> Bool {
        if case Optional<Any>.none = any {
            return true
        }
        
        if any is NSNull {
            return true
        }
        
        return false
    }
    
    /*----------------------------------------------------------------------------*/
    ///  Chuyển đối dữ liệu sang optional
    /// - Author: Phùng Ngọc Huề
    /// - Date: 21/8/2019
    static public func optionalAny(_ any: Any) -> Any? {
        return Optional.some(any)
    }
    
    static public func getDataFromParam(param: Any) -> Data? {
        return try? JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
    
    ///  lấy ra số tiếng giữa 2 thời gian
    /// - Author: GIANG PHAN BA
    /// - Date: 28/09/2023
    static func hoursBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: startDate, to: endDate)
        
        if let hours = components.hour {
            return hours
        } else {
            return 0
        }
    }
    
    ///  lấy ra số tiếng giữa 2 thời gian
    /// - Author: GIANG PHAN BA
    /// - Date: 28/09/2023
    static func minutesBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: startDate, to: endDate)
        
        if let minutes = components.minute {
            return minutes
        } else {
            return 0
        }
    }
    
    /// Hàm lấy ra thông tin tên và đuôi của ảnh - dùng cho DKImagePickerController
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 10/04/2019
    class func getImageInfo(dkImageInfo: [AnyHashable: Any]?) -> (name: String, ext: String) {
        guard let dkImageInfo = dkImageInfo else { return ("","")}
        
        var imgExtension = ""
        var imgName = ""
        
        var fileName = dkImageInfo["AMIS_FileName"] as? String
        if fileName == nil {
            if let fileURL: URL = dkImageInfo["PHImageFileURLKey"] as? URL {
                fileName = fileURL.lastPathComponent
            }
        }
        
        if let fileName = fileName {
            let fileComponent = fileName.components(separatedBy: ".")
            if fileComponent.count > 1 {
                for i in 0..<fileComponent.count {
                    if i == fileComponent.count - 1 {
                        imgExtension = fileComponent[i]
                    }else{
                        imgName = imgName + fileComponent[i]
                    }
                }
            }
        }
        
        // Thêm dấu phân cách dữ liệu
        if imgExtension.hasPrefix(".") == false{
            imgExtension = "." + imgExtension
        }
        
        return (imgName,imgExtension)
    }
    
    class func forceDismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    // gọi điện thoại
    private class func callPhoneNumber(url: String?) {
        if let url = URL(string: "tel://\(url ?? "")") , UIApplication.shared.canOpenURL(url){
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    /*----------------------------------------------------------------------------*/
    ///  Show AlertViewcontroller chọn gọi qua stringee hay gọi bằng native system
    /// - Author: Phùng Ngọc Huề
    /// - Date: 26/6/2019
    /// - Parameter phoneNumber: Số điện thoại cần gọi
    /// - Parameter systemCall: Chế độ gọi - gọi bằng Stringee hay bằng System
    /// - Parameter viewController: View controller thực hiện việc gọi, dùng để present popup
    /// - Parameter dataCallModule: dữ liệu bổ sung
//    class func showDialogCall(phoneNumber: String, systemCall: ESystemCall, viewController: UIViewController? = nil,module: String?, callItem: LogCallObject? = nil) {
//        let phoneNumberStandard  = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression, range: nil)
//        
//        guard phoneNumberStandard.isEmpty == false else {
//            MISAToast.showUnknownError()
//            return
//        }
//        // Lưu thông tin cuộc gọi lại nếu có
//        APPDELEGATE.callItem = callItem
//        
//        let loginObject = MSCache.getLoginObject()
//        
//        // R45 check hiển thị thêm gọi qua Omicall
//        
//        if loginObject?.stringeePhoneNumber?.count > 0 || loginObject?.omiCallProviderConfig
//         != nil{
//            selectCallType(module: module,viewController: viewController, phoneNumberStandard: phoneNumberStandard,callItem : callItem, loginObject: loginObject)
//        }else{
//            
//            UtilCRM.callPhoneNumber(url: phoneNumberStandard)
//        }
//    
//        // Log analytic
//        FireBaseAnalyticsBusiness.logEvent(event: .Call, moduleSource: callItem?.fromModule)
//    }
    
    
//    class func selectCallType(module : String?,viewController: UIViewController?, phoneNumberStandard : String, callItem: LogCallObject? = nil, loginObject: LoginResultObject? = nil){
//        var optionList: [SimplePickerObject] = []
//        let ob1 = SimplePickerObject(name : "Call_Normal_Label".localize())
//        ob1.tag = 1
//        optionList.append(ob1)
//        if loginObject?.stringeePhoneNumber?.count > 0{
//            let ob2 = SimplePickerObject( name: "Call_Stringee_Label".localize())
//            ob2.tag = 2
//            optionList.append(ob2)
//        }
//        
//        if loginObject?.omiCallProviderConfig != nil{
//            let ob3 = SimplePickerObject( name: "Call_Omicall_Label".localize())
//            ob3.tag = 3
//            optionList.append(ob3)
//        }
//        
//        let simplePicker = SimplePickerViewController(dataList:optionList)
//        let nav = BaseNavigationViewController(rootViewController: simplePicker)
//        simplePicker.navigationItem.title = "Call_Type_Label".localize()
//        simplePicker.didSelectObject = {[weak viewController] (option) in
//            
//            if option?.tag == 1 {
//                // gọi thường
//                UtilCRM.callPhoneNumber(url: phoneNumberStandard)
//            }else if option?.tag == 2 {
//                // gọi qua Stringee
//                if let hotline = MSCache.getLoginObject()?.stringeePhoneNumber{
//                    
//                    if hotline.count == 1 {
//                        if let toPhone = PhoneNumberBusiness.getPhoneNumberForStringee(phoneNumber: phoneNumberStandard, region: ServerConfig.phoneNumberConutryCode), let hotlineString = hotline.first?.number  {
//                            StringeeCallCenter.shared.makeCall(hotline: hotlineString , to: toPhone , false, dataDetailMaster: callItem?.dataDetailMaster, module: module)
//                        }else{
//                            UtilCRM.callPhoneNumber(url: phoneNumberStandard)
//                        }
//                    }else{
//                        var dataList: [SimplePickerObject] = []
//                        for item in hotline{
//                            if let number = item.number {
//                                let picker = SimplePickerObject(name: number, obj: number)
//                                
//                                dataList.append(picker)
//                            }
//                        }
//                        let pickerVC = SimplePickerNewViewController(titleVC: "SFVC_TitlePhone".localize(), dataList: dataList)
//                        pickerVC.didSelectObject = { (itemPicker) in
//                            
//                            if let phoneNumber = itemPicker?.obj as? String{
//                                if let toPhone = PhoneNumberBusiness.getPhoneNumberForStringee(phoneNumber: phoneNumberStandard, region: ServerConfig.phoneNumberConutryCode) {
//                                    StringeeCallCenter.shared.makeCall(hotline: phoneNumber , to: toPhone , false, dataDetailMaster: callItem?.dataDetailMaster, module: module)
//                                }else{
//                                    UtilCRM.callPhoneNumber(url: phoneNumberStandard)
//                                }
//                            }
//                            
//                        }
//                        viewController?.showSheet(controller: pickerVC, sizes: [.fixed(pickerVC.estimatedHeight())])
//                    }
//                }
//                
//            }else if option?.tag == 3{
//                // gọi qua omicall
//                //MSOmicall.shareInstance().makeCall(phoneNumber: phoneNumberStandard,dataDetailMaster: callItem?.dataDetailMaster, module: module)
//            }
//            
//        }
//        viewController?.showSheet(controller:nav, sizes: [.fixed(simplePicker.estimatedHeight())])
//    }
    
    class func addHttpToUrl(stringURL: String) -> String {
        if stringURL.hasPrefix("http://") || stringURL.hasPrefix("https://"){
            return stringURL
        } else {
            return String.init(format:"http://%@",stringURL)
        }
    }
    
    class func readFileJson(fileName: String) -> [String: Any]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json"), let stringJson = try? Data(contentsOf: URL(fileURLWithPath: path)), let jsonResult = try? JSONSerialization.jsonObject(with: stringJson, options: .mutableContainers) as? [String : Any] else {
            return nil
        }
        
        return jsonResult
    }
    
    class func convertStringToJson(stringJson: String) -> [String: Any]? {
        let dataJson = Data(stringJson.utf8)
        guard let jsonResult = try? JSONSerialization.jsonObject(with: dataJson, options: .mutableContainers) as? [String : Any] else {
            return nil
        }
        
        return jsonResult
    }
    
    class func getAspectHeight(width: CGFloat?, height: CGFloat?, fixedWidth: CGFloat) -> CGFloat{
        guard let width = width, let height = height, width > 0, height > 0 else { return 0}
        return height * fixedWidth / width
    }
    
    class func getAspectWidth(width: CGFloat?, height: CGFloat?, fixedHeight: CGFloat) -> CGFloat{
        guard let width = width, let height = height, width > 0, height > 0 else { return 0}
        return width * fixedHeight / height
    }
    
    /// Tính thời gian gọi sang --m:--s
    /// - Author: hqtuan
    /// - Date: 26/06/2019
//    class func caculatorCallDuration(callDuration: Int?) -> String {
//        if let callDuration = callDuration, callDuration >= 0 {
//            let min: Int = callDuration / 60
//            let second: Int = callDuration % 60
//            let durationString = String(format: LocalizeHelper.getStringForKey("Common_Format_CallDuration"), min, second)
//            return durationString
//        }else{
//            return LocalizeHelper.getStringForKey("CDVC_CallDuration")
//        }
//    }
    
    /// Hàm tính toán và trả về các bộ kích thước cho từng collection view cell để nhìn giống layout của facebook
    /// - Author: Nguyễn Sỹ Tân
    /// - Date: 10/07/2019
//    class func calculateSizesForCollectionViewCell(itemsCount: Int, patternSize: Int = 5, collectionViewWidth: CGFloat = SCREEN_WIDTH, padding: CGFloat = 4) -> (sizes:[CGSize], collectionViewHeight: CGFloat) {
//        
//        var collectionViewCellList: [CGSize] = []
//        let maxWidth = collectionViewWidth
//        
//        var cellWidth: CGFloat = 0
//        
//        var maxHeight: CGFloat = 0
//        
//        
//        if itemsCount < 1 {
//        }else if itemsCount == 1 {
//            collectionViewCellList.append(CGSize(width: maxWidth, height: maxWidth / 2.0))
//            maxHeight = maxWidth / 2.0
//        }else if itemsCount == 2 {
//            cellWidth = (maxWidth - padding) / 2.0
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            maxHeight = cellWidth
//        } else if itemsCount == 3 {
//            collectionViewCellList.append(CGSize(width: maxWidth, height: maxWidth / 2.0))
//            cellWidth = (maxWidth - padding) / 2.0
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            maxHeight = maxWidth / 2.0 + padding + cellWidth
//        } else if itemsCount == 4 {
//            collectionViewCellList.append(CGSize(width: maxWidth, height: maxWidth / 2.0))
//            cellWidth = ((maxWidth - 2.0*padding) / 3.0).rounded(.down) // kích thước của mỗi cell là A = (maxWidth - 2.0*padding) / 3.0); Cần làm tròn A tới 1 chữ số sau dấu phẩy để dễ tính toán ==> Nhân A lên 10 rồi làm tròn --> sau đó chia lại cho 10
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            let remainWidth = maxWidth - 2 * cellWidth - 2 * padding // Dồn hết khoàng cách còn lại cho item cuối
//            collectionViewCellList.append(CGSize(width: remainWidth , height: cellWidth))
//            maxHeight = maxWidth / 2.0 + padding + cellWidth
//        }else{
//            cellWidth = (maxWidth - padding) / 2.0
//            collectionViewCellList.append(CGSize(width: cellWidth, height: maxWidth / 2.0))
//            collectionViewCellList.append(CGSize(width: cellWidth, height: maxWidth / 2.0))
//            cellWidth = ((maxWidth - 2.0*padding) / 3.0).rounded(.down) // kích thước của mỗi cell là A = (maxWidth - 2.0*padding) / 3.0); Cần làm tròn A tới 1 chữ số sau dấu phẩy để dễ tính toán ==> Nhân A lên 10 rồi làm tròn --> sau đó chia lại cho 10
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            collectionViewCellList.append(CGSize(width: cellWidth, height: cellWidth))
//            let remainWidth = maxWidth - 2 * cellWidth - 2 * padding // Dồn hết khoàng cách còn lại cho item cuối
//            collectionViewCellList.append(CGSize(width: remainWidth , height: cellWidth))
//            maxHeight = maxWidth / 2.0 + padding + cellWidth
//            
//        }
//        
//        return (collectionViewCellList, maxHeight)
//    }
    
    /*----------------------------------------------------------------------------*/
    /// Lấy thông tin HTML Stype
    /// - Author: Phùng Ngọc Huề
    /// - Date:24/3/2020
//    class func getHTMLStyle(fontSize: CGFloat = 16) -> StyleGroup {
//        // Lấy thông tin font cơ bản theo size
//        let fontRegular = ThemeManager.getCacheFont().regular(size: fontSize)
//        let fontBold = ThemeManager.getCacheFont().bold(size: fontSize)
//        
//        let headerStyle = Style {
//            $0.font = fontBold
//            $0.lineSpacing = 1
//            $0.kerning = Kerning.adobe(-20)
//        }
//        let boldStyle = Style {
//            $0.font = fontBold
//            if #available(iOS 11.0, *) {
//                $0.dynamicText = DynamicText {
//                    $0.style = .body
//                    $0.maximumSize = 35.0
//                    $0.traitCollection = UITraitCollection(userInterfaceIdiom: .phone)
//                }
//            }
//        }
//        let italicStyle = Style {
//            $0.font = fontRegular
//        }
//        
//        let htmlStyle : StyleGroup = StyleGroup(base: Style {
//            $0.font = fontRegular
//            $0.lineSpacing = 2
//            $0.kerning = Kerning.adobe(-15)
//            }, [
//                "h3": headerStyle,
//                "h4": headerStyle,
//                "h5": headerStyle,
//                "strong": boldStyle,
//                "b": boldStyle,
//                "em": italicStyle,
//                "i": italicStyle,
//                "li": Style {
//                    $0.paragraphSpacingBefore = fontSize / 2
//                    $0.firstLineHeadIndent = fontSize
//                    $0.headIndent = fontSize * 1.71
//                },
//                "sup": Style {
//                    $0.font = UIFont.systemFont(ofSize: fontSize / 1.2)
//                    $0.baselineOffset = Float(fontSize) / 3.5
//                }])
//        
//        return htmlStyle
//    }
}

extension Thread {
    class func runOnMain(block: @escaping (() -> Void)){
        if Thread.isMainThread == false {
            DispatchQueue.main.async(execute: {
                block()
            })
        }else{
            block()
        }
    }
    
    class func runOnMain(after: TimeInterval,block: @escaping (() -> Void)){
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            block()
        }
    }
    
    
    class func runOnBackground(block: @escaping (() -> Void)){
        if Thread.isMainThread == true {
            DispatchQueue(label: "QueueIdentification", qos: .background).async(execute: {
                block()
            })
        }else{
            block()
        }
    }
    
}
