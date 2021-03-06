//
//  DebugMenu.swift
//  StressSensorApp
//
//  Created by Carlo Rapisarda on 25/02/2019.
//  Copyright © 2019 AssistiveTech KTH. All rights reserved.
//

import UIKit

struct DebugMenu {

    static func present(on controller: UIViewController) {

        let state = mainStore.state.debug
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actions = [
            UIAlertAction(
                title: "Add noise to signals (\(state.addNoiseToSignals))",
                style: .default,
                handler: { _ in mainStore.safeDispatch(Actions.AddNoiseToSignals(value: !state.addNoiseToSignals)) }
            ),
            UIAlertAction(
                title: "Use fake snapshots (\(state.useFakeSnapshots))",
                style: .default,
                handler: { _ in mainStore.safeDispatch(Actions.UseFakeSnapshots(value: !state.useFakeSnapshots)) }
            ),
            UIAlertAction(
                title: "Disable cooldown (\(state.disableCooldown))",
                style: .default,
                handler: { _ in mainStore.safeDispatch(Actions.DisableCooldown(value: !state.disableCooldown)) }
            ),
            UIAlertAction(
                title: "Fake predictions (\(state.fakePredictions))",
                style: .default,
                handler: { _ in mainStore.safeDispatch(Actions.FakePredictions(value: !state.fakePredictions)) }
            ),
            UIAlertAction(
                title: "Present visual consent",
                style: .default,
                handler: { _ in
                    if let vc = controller as? DayViewController {
                        vc.consentManager = ConsentManager()
                        vc.consentManager?.present(on: vc)
                    }
                }
            ),
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
        ]
        actions.forEach { actionSheet.addAction($0) }

        let view = controller.view!
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)

        controller.present(actionSheet, animated: true, completion: nil)
    }
}
