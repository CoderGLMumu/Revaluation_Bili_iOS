//
//  QRCodeTool.swift
//  读取二维码
//
//  Created by oneAlon on 15/3/24.
//  Copyright © 2016年 王亚龙. All rights reserved.
//

import UIKit
import AVFoundation


// 存放属性

typealias ScanResult = (resultStrs: [String])->()

//var strs =
//private lazy var strs : [String] = {
//   return [String]()
//}()
private var strs : [String] = [String]()

class QRCodeTool: NSObject {
    
    var isGetQR : Bool = false

    // 单例
    static let shareInstance = QRCodeTool()
    
    // 扫描结果的闭包
    private var scanResultBlock: ScanResult?
    
    // 懒加载输入
    private lazy var input: AVCaptureDeviceInput? = {
       
        // 1. 获取摄像头设备
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // 2. 设置为输入设备
        var input: AVCaptureDeviceInput?
        do {
            input = try AVCaptureDeviceInput(device: device)
        
        }catch {
            print(error)
            return nil
        }
        
        return input
    
    }()
    
    // 懒加载输出
    private lazy var output: AVCaptureMetadataOutput = {
        // 1. 创建元数据输出处理对象
        let output = AVCaptureMetadataOutput()
        // 2. 设置元数据输出处理的代理, 来接收输出的数据内容
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        return output
        
    }()
    
    // 会话
    private lazy var session: AVCaptureSession = {
        // 3. 创建会话, 连接输入和输出
        let session = AVCaptureSession()
        return session
    }()
    
    // 预览图层
    private lazy var layer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        return layer
        
    }()
    
    var isDraw: Bool = false
}

/** 二维码扫描的接口 */
extension QRCodeTool {
    
    func scanQRCode(inView: UIView, isDraw: Bool, resultBlock: ScanResult?) -> () {
        
        // 0. 记录block, 在合适的地方执行
        scanResultBlock = resultBlock
        self.isDraw = isDraw

        // 1. 添加输入和输出
        if session.canAddInput(input) && session.canAddOutput(output)
        {
            session.addInput(input)
            session.addOutput(output)
        }
        
        // 3.1 设置扫描识别的类型
        // output.availableMetadataObjectTypes, 识别所有的类型
        // 如果设置这个属性, 在添加到session之前会崩溃, 识别不了
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        // 3.2 添加视频预览图层(不是必须)
       
        let sublayers = inView.layer.sublayers
        if sublayers == nil || !sublayers!.contains(layer)
        {
            layer.frame = inView.bounds
            inView.layer.insertSublayer(layer, atIndex: 0)
        }
        
        // 4. 启动会话, 开始扫描
        session.startRunning()
    }
    
    func scanQRCode_stop(){
        session.stopRunning()
    }
    
    
    func setInterestRect(rect: CGRect) -> () {
        // 3.3 设置扫描区域
        // 1. 这个矩形, 是一个比例(0.0 - 1.0)
        // 2. 这个矩形, 是横屏状态下的矩形
        let size = UIScreen.mainScreen().bounds
        let x: CGFloat = rect.origin.x / size.width
        let y: CGFloat = rect.origin.y / size.height
        let w: CGFloat = rect.size.width / size.width
        let h: CGFloat = rect.size.height / size.height

        output.rectOfInterest = CGRectMake(y, x, h, w)
    }
    
    
    
}


/** 二维码生成, 二维码识别的接口 */
extension QRCodeTool {
    
    
    /// 生成一个二维码
    // 参数1: 需要生成二维码的字符串
    // 参数2: 中间的自定义图片(可以为空, 如果是空的话, 代表不需要自定义图片)
    // 返回值: 生成后的二维码图片
    class func generatorQRCode(contentStr: String, centerImage: UIImage?) -> UIImage {
        
        // 生成二维码
        
        // 1. 创建一个二维码滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        // 1.1 恢复默认设置
        filter?.setDefaults()
        
        // 2. 设置输入的内容
        // 通过KVC, 设置一个属性
        // 输入的内容必须是NSData
        let inputStr = contentStr
        let data = inputStr.dataUsingEncoding(NSUTF8StringEncoding)
        filter?.setValue(data, forKey: "inputMessage")
        
        // 2.1 设置滤镜的纠错率
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        
        // 3. 取出生成的图片
        var outImage = filter?.outputImage
        let transform = CGAffineTransformMakeScale(20, 20)
        outImage = outImage?.imageByApplyingTransform(transform)
        
        // 4. 展示(23.0, 23.0)
        var imageUI = UIImage(CIImage: outImage!)
        
        
        // 5. 添加一个自定义图片
        if centerImage != nil {
            imageUI = createImage(imageUI, centerImage: centerImage!)
            
        }
        
        
        return imageUI
    }
    
    /// 识别二维码的内容
    // 参数1: 需要识别的二维码
    // 参数2: 是否要求, 需要绘制边框的二维码图像
    // 返回值: 元组(参数1: 识别出来的结果数组, 参数2: 描绘边框后的二维码图像)
    class func detectorQRCode(image: UIImage, isDraw: Bool) -> (resultStrs: [String], resultImage: UIImage) {
        
        
        // 1. 创建二维码探测器
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        // 2. 探测图片特征
        let imageCI = CIImage(image: image)
        let result = detector.featuresInImage(imageCI!)
        
        // 3. 遍历特征, 打印结果
        var strs = [String]()
        var tempImage = image
        for feature in result {
            let qrCodeFeature = feature as! CIQRCodeFeature
            //            print(qrCodeFeature.messageString)
            strs.append(qrCodeFeature.messageString)
            
            
            if isDraw {
                tempImage = drawFrame(tempImage, feature: qrCodeFeature)
            }
            
        }
        
        return (strs, tempImage)
        
    }
    
    
}


/** 私有方法, 只是用在工具类内部, 不直接暴露给外界使用 */
extension QRCodeTool {
    
    // 根据二维码特征, 绘制二维码边框
    class private func drawFrame(sourceImage: UIImage, feature: CIQRCodeFeature) -> UIImage {
        
        
        let size = sourceImage.size
        // 1. 开启上下文
        UIGraphicsBeginImageContext(size)
        
        
        // 2. 绘制图片
        sourceImage.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        // 修改坐标(上下颠倒)
        let context = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(context, 1, -1)
        CGContextTranslateCTM(context, 0, -size.height)
        
        // 3. 绘制线宽
        let path = UIBezierPath(rect: feature.bounds)
        UIColor.redColor().setStroke()
        path.lineWidth = 6
        path.stroke()
        
        // 4. 取出合成后的图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5. 关闭上下文
        UIGraphicsEndImageContext()
        
        // 6. 返回结果
        return resultImage
        
        
        
    }

    
    // 根据给定的两个图片, 生成一个合成后的图片
    class private func createImage(sourceImage: UIImage, centerImage: UIImage) -> UIImage {
        
        let size = sourceImage.size
        // 1. 开启上下文
        UIGraphicsBeginImageContext(size)
        
        
        // 2. 绘制大图片
        sourceImage.drawInRect(CGRectMake(0, 0, size.width, size.height))
        
        // 3. 绘制小图片
        let w: CGFloat = 80
        let h: CGFloat = 80
        let x: CGFloat = (size.width - w) * 0.5
        let y: CGFloat = (size.height - h) * 0.5
        
        centerImage.drawInRect(CGRectMake(x, y, w, h))
        
        // 4. 取出结果图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        
        // 5. 关闭上下文
        UIGraphicsEndImageContext()
        
        // 6. 返回结果
        return resultImage
        
        
        
        
        
    }
    
    
    private func drawQRCodeFrame(codeObj: AVMetadataMachineReadableCodeObject) -> () {
        
        // 绘制边框
        // 1. 创建图形的图层
        let shapLayer = CAShapeLayer()
        shapLayer.fillColor = UIColor.clearColor().CGColor
        shapLayer.strokeColor = UIColor.redColor().CGColor
        shapLayer.lineWidth = 6
        // 2. 设置需要显示的图形路径
        let corners = codeObj.corners
        // 2.1 创建一个路径
        let path = UIBezierPath()
        
        var index = 0
        for corner in corners {
            
            //            X = "130.4106779769043";
            //            Y = "304.6985145489584";
            // 转换成为一个CGPoint
            var point  = CGPointZero
            CGPointMakeWithDictionaryRepresentation(corner as! CFDictionary, &point)
            
            if index == 0 {
                path.moveToPoint(point)
            }else {
                path.addLineToPoint(point)
            }
            
            index += 1
        }
        path.closePath()
        
        shapLayer.path = path.CGPath
        
        
        // 3. 添加到需要展示的图层
        layer.addSublayer(shapLayer)
        
        
        
    }

    private func removeQRCodeFrameLayer() -> () {
        guard let subLayers = layer.sublayers else { return }
        
        for subLayer in subLayers {
            if subLayer.isKindOfClass(CAShapeLayer) {
                subLayer.removeFromSuperlayer()
            }
        }
        
    }

    
}


extension QRCodeTool: AVCaptureMetadataOutputObjectsDelegate {
    
    // 扫描到结果之后, 调用
    // 最后一次也会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if isDraw {
             removeQRCodeFrameLayer()
        }
       
        
        
        for obj in metadataObjects {
            
            // AVMetadataMachineReadableCodeObject, 二维码的数据模型
            if obj.isKindOfClass(AVMetadataMachineReadableCodeObject)
            {
                // 借助layer来转换,,四个角的坐标
                let resultObj = layer.transformedMetadataObjectForMetadataObject(obj as! AVMetadataObject)
                let codeObj = resultObj as! AVMetadataMachineReadableCodeObject

                
                strs.append(codeObj.stringValue)
                
                
//                if strs.contains(codeObj.stringValue){ // 如果数组中已经包含了扫描到的内容
//                    return
//                }else if scanResultBlock != nil { // 如果有要执行的block
//                    scanResultBlock!(resultStrs: strs)
//                }
//                print("\(codeObj.stringValue)--------")
   
                
                if isGetQR == true {
                    return
                }else{
                    // 调用block
                    if scanResultBlock != nil {
                        scanResultBlock!(resultStrs: strs)
                        isGetQR = true
                    }
                }
                
                
                // 描绘边框
                if isDraw {
                    drawQRCodeFrame(codeObj)

                }
            }
        }
    }
    
}



