//
//  XCTestCase+Snapshot.swift
//  EssentialFeediOSTests
//
//  Created by Leandro Fournier on 8/9/23.
//

import XCTest

extension XCTestCase {

    func assert(snapshot: UIImage, named name: String, file: StaticString = #file, line: UInt = #line) {
        let snapshotURL = makeSnapshotURLForAssertion(named: name)
        let snapshotData = makeSnapshotData(for: snapshot, file: file, line: line)

        guard let storedSnapshotData = try? Data(contentsOf: snapshotURL) else {
            XCTFail("Failed to load stored snapshot at URL: \(snapshotURL). Use the `record` method to store a snapshot before asserting.", file: file, line: line)
            return
        }

        if snapshotData != storedSnapshotData {
            let temporarySnapshotURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                .appendingPathComponent(snapshotURL.lastPathComponent)

            try? snapshotData?.write(to: temporarySnapshotURL)

            XCTFail("New snapshot does not match stored snapshot. New snapshot URL: \(temporarySnapshotURL), Stored snapshot URL: \(snapshotURL)", file: file, line: line)
        }
    }

    func record(snapshot: UIImage, named name: String, file: StaticString = #file, line: UInt = #line) {
        let snapshotURL = makeSnapshotURLForRecording(named: name, file: file)
        let snapshotData = makeSnapshotData(for: snapshot, file: file, line: line)

        do {
            try FileManager.default.createDirectory(
                at: snapshotURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )

            try snapshotData?.write(to: snapshotURL)
        } catch {
            XCTFail("Failed to record snapshot with error: \(error)", file: file, line: line)
        }
    }

    private func makeSnapshotURLForRecording(named name: String, file: StaticString) -> URL {
        let path = URL(filePath: String(describing: file)).deletingLastPathComponent()
        return makeSnapshotURL(named: name, atBasePath: path)
    }

    private func makeSnapshotURLForAssertion(named name: String) -> URL {
        let path = Bundle(for: FeedSnapshotTests.self).bundleURL
        return makeSnapshotURL(named: name, atBasePath: path)
    }

    private func makeSnapshotURL(named name: String, atBasePath path: URL) -> URL {
        return path.appending(component: "Snapshots").appending(component: "\(name).png")
    }

    private func makeSnapshotData(for snapshot: UIImage, file: StaticString, line: UInt) -> Data? {
        guard let data = snapshot.pngData() else {
            XCTFail("Failed to generate PNG data representation from snapshot", file: file, line: line)
            return nil
        }

        return data
    }
}
