//
//  ContentView.swift
//  My360iDevApp
//
//  Created by Florian Harr on 8/20/21.
//

import SwiftUI

class LocalJSONFileSource: ObservableObject {
    @Published var codableView: CodableView?
    
    private let fileMonitor: FileMonitor
    private let pathURL: URL
    
    init() {
        self.pathURL = URL(fileURLWithPath: "/Users/evils/codableViews.json")
        self.fileMonitor = FileMonitor(url: pathURL)
        
        fileMonitor.fileDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshJSON()
            }
        }
        
        fileMonitor.startMonitoring()
        refreshJSON()
    }
    
    func refreshJSON() {
        do {
            codableView = try JSONDecoder().decode(CodableView.self, from: Data(contentsOf: pathURL))
        } catch {
            print(error)
        }
    }
}

struct ContentView: View {
    @StateObject var localJSONFileSource = LocalJSONFileSource()
    
    var body: some View {
        if let codableView = localJSONFileSource.codableView {
            ViewFactory.view(for: codableView)
        }
    }
}
