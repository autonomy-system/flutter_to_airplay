//
//  FlutterRoutePickerView.swift
//  flutter_to_airplay
//
//  Created by Junaid Rehmat on 22/08/2020.
//

import Foundation
import AVKit
import MediaPlayer
import Flutter

class AirplayView: UIView {
    let routePickerView = AVRoutePickerView(frame: .init(x: -8.0, y: 0.0, width: 44.0, height: 44.0))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(routePickerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return routePickerView
        }
        return hitView
    }
}

class FlutterRoutePickerView: NSObject, FlutterPlatformView {
    private var _flutterRoutePickerView : UIView;
    
    init(frame:CGRect,
              viewIdentifier: CLongLong,
              arguments: Dictionary<String, Any>,
              binaryMessenger: FlutterBinaryMessenger) {
        if #available(iOS 11.0, *) {
            let tempView = AirplayView(frame: frame)
            if let tintColor = arguments["tintColor"] {
                let color = tintColor as! Dictionary<String, Any>
                tempView.routePickerView.tintColor = UIColor.init(red: color["red"] as! CGFloat,
                                                  green: color["green"] as! CGFloat,
                                                  blue: color["blue"] as! CGFloat,
                                                  alpha: color["alpha"] as! CGFloat)
            }
            if let tintColor = arguments["activeTintColor"] {
                let color = tintColor as! Dictionary<String, Any>
                tempView.routePickerView.activeTintColor = UIColor.init(red: color["red"] as! CGFloat,
                                                  green: color["green"] as! CGFloat,
                                                  blue: color["blue"] as! CGFloat,
                                                  alpha: color["alpha"] as! CGFloat)
            }
            if let tintColor = arguments["backgroundColor"] {
                let color = tintColor as! Dictionary<String, Any>
                tempView.routePickerView.backgroundColor = UIColor.init(red: color["red"] as! CGFloat,
                                                  green: color["green"] as! CGFloat,
                                                  blue: color["blue"] as! CGFloat,
                                                  alpha: color["alpha"] as! CGFloat)
            }

            if let prioritizesVideoDevices = arguments["prioritizesVideoDevices"] as? Bool {
                tempView.routePickerView.prioritizesVideoDevices = prioritizesVideoDevices;
            }

            _flutterRoutePickerView = tempView
        } else {
            let tempView = MPVolumeView(frame: .init(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
            tempView.showsVolumeSlider = false
            _flutterRoutePickerView = tempView
        }
    }
    func view() -> UIView {
        return _flutterRoutePickerView
    }
    
    
}
