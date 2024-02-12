//
//  alias.swift
//  libtest
//
//  Created by Imai Hiroshi on 2/12/24.
//

#if !os(OSX)
import UIKit
#else
import Cocoa
#endif

import maiimaiiUtilitis

class alias: NSObject {
	typealias x = maiimaiiUtilitis.MT
}
