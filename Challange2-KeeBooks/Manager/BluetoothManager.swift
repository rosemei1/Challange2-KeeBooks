//
//  BluetoothManager.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 26/05/26.
//

import SwiftUI
import AVFoundation
import SwiftData

@Observable
class BluetoothManager {

    var isConnected: Bool = false
    var deviceName: String?

    init() {
        update()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(routeChanged),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )
    }

    @objc private func routeChanged(_ notification: Notification) {
        update()
    }

    private func update() {
        let outputs = AVAudioSession.sharedInstance().currentRoute.outputs

        let bluetoothOutput = outputs.first(where: {
            $0.portType == .bluetoothA2DP ||
            $0.portType == .bluetoothLE ||
            $0.portType == .bluetoothHFP
        })

        DispatchQueue.main.async {
            self.isConnected = bluetoothOutput != nil
            self.deviceName = bluetoothOutput?.portName
        }
    }
}
