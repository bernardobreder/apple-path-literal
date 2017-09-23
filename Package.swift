//
//  Package.swift
//  PathLiteral
//
//

import PackageDescription

let package = Package(
	name: "PathLiteral",
	targets: [
		Target(name: "PathLiteral", dependencies: ["Literal", "Path"]),
		Target(name: "Literal", dependencies: []),
		Target(name: "Path", dependencies: []),
	]
)

