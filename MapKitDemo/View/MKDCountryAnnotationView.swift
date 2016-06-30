//
//  MKDCountryAnnotationView.swift
//  MapKitDemo
//
//  Created by Robin Sun on 29/06/2016.
//  Copyright © 2016 Robin Sun. All rights reserved.
//

import UIKit
import DXCustomCallout_ObjC

class MKDCountryAnnotationView: DXAnnotationView {
    var calloutView:MKDCountryCalloutView?
    
    override init!(annotation: MKAnnotation!, reuseIdentifier: String!, pinView: UIView!, calloutView: UIView!, settings: DXAnnotationSettings!) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier, pinView: pinView, calloutView: calloutView, settings: settings)

        // update the size and position of callout view
        if let calloutView = calloutView as? MKDCountryCalloutView {
            self.calloutView = calloutView
            let size = calloutView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            calloutView.bounds = CGRectMake(0, 0, size.width, size.height)
            repositionSubviews()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // reposition subviews
    func repositionSubviews() {
        if var frame = self.calloutView?.frame {
            frame.origin.y = -frame.size.height - 5.0
            frame.origin.x = (self.frame.size.width - frame.size.width) / 2.0;
            self.calloutView?.frame = frame
        }
    }
}
