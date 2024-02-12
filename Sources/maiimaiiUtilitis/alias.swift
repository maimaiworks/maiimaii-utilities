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

public class alias: NSObject {
	public typealias x = maiimaiiUtilitis.MT
}
