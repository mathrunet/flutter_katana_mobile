// Copyright 2021 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:katana_mobile/katana_mobile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Mobile config Demo",
      home: MobileConfigDemo(),
    );
  }
}

class MobileConfigDemo extends StatefulWidget {
  const MobileConfigDemo();

  @override
  State<StatefulWidget> createState() => MobileConfigDemoState();
}

class MobileConfigDemoState extends State<MobileConfigDemo> {
  @override
  void initState() {
    super.initState();
    MobileConfig.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile config Demo"),
      ),
      body: Center(
        child: Text(
            MobileConfig.isInitialized ? "Initialized" : "Not initialized"),
      ),
    );
  }
}
