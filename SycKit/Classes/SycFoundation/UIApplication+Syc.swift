//
//  UIApplication+Syc.swift
//  SycKit
//
//  Created by syc on 2021/7/12.
//

import UIKit

extension SycStruct where Base: UIApplication {
    
    /// 是否在 Debug 环境下
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// 是否 模拟器 运行
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    /// 是否从 Xcode 运行
    public static var isBeginXcode: Bool {
        // Initialize all the fields so that,
        // if sysctl fails for some bizarre reason, we get a predictable result.
        // 创建一个完全初始化的结构，其中所有字段都设置为零，因此info.kp_proc.p_flag = 0不需要设置。
        var info = kinfo_proc()
        // Initialize mib, which tells sysctl the info we want,
        // in this case we're looking for info about a specific process ID.
        var mib = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        // Call sysctl.
        var size = MemoryLayout.stride(ofValue: info)
        let junk = sysctl(&mib, u_int(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        // We're being debugged if the P_TRACED flag is set.
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
}
