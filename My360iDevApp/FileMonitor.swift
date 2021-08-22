//
//  FileMonitor.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/21/21.
//

import Foundation

public class FileMonitor {
    private static let fileMonitorQueue = DispatchQueue(label: "FileMonitorQueue", attributes: .concurrent)
    private var monitoredFileDescriptor: Int32 = -1
    private var fileMonitorSource: DispatchSourceFileSystemObject?
    let url: URL
    
    var fileDidChange: (() -> Void)?

    init(url: URL) {
        self.url = url
    }

    func startMonitoring() {
        guard fileMonitorSource == nil && monitoredFileDescriptor == -1 else {
            return
        }
        monitoredFileDescriptor = open(url.path, O_EVTONLY)
        guard monitoredFileDescriptor != -1 else {
            // errno returns EPERM on Mac OS here
            return
        }
        fileMonitorSource = DispatchSource.makeFileSystemObjectSource(fileDescriptor: monitoredFileDescriptor, eventMask: .write, queue: Self.fileMonitorQueue)
        fileMonitorSource?.setEventHandler { [weak self] in
            self?.fileDidChange?()
        }
        fileMonitorSource?.setCancelHandler { [weak self] in
            guard let strongSelf = self, strongSelf.monitoredFileDescriptor != -1 else { return }
            close(strongSelf.monitoredFileDescriptor)
            strongSelf.monitoredFileDescriptor = -1
            strongSelf.fileMonitorSource = nil
        }
        fileMonitorSource?.resume()
    }

    func stopMonitoring() {
        fileMonitorSource?.cancel()
    }
    
    deinit {
        stopMonitoring()
    }
}
