//
//  Extensions.swift
//  Project
//
//  Created by Kaan Uzun on 26.01.2024.
//

import Foundation
import UIKit

extension UIView {
  var width: CGFloat {
    return frame.size.width
  }
  
  var height: CGFloat {
    return frame.size.height
  }

  var left: CGFloat {
    return frame.origin.x
  }

  var right: CGFloat {
    return left + width
  }

  var bottom: CGFloat {
    return top + height
  }

  var top: CGFloat {
    return frame.origin.y
  }



}
