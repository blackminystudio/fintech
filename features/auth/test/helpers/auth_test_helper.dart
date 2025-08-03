// test values
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const testUid = 'uid_alice_123';
const testEmail = 'alice@example.com';
const testUpdatedEmail = 'updated@test.com';
const testDisplayName = 'Alice';
const testUpdatedName = 'Bob';
const testPhotoUrl = 'https://avatar/';
final testCreatedAt = DateTime(2025, 1, 1, 12);
final testLastLoginAt = DateTime(2025, 1, 2, 8, 30);

// Mocks
const testError = 'test-error';
const testMessage = 'something went wrong';
const testPlugin = 'firebase_auth';
const testCode = 'failed';

// new values
const newEmail = 'bob@example.org';
final newLastLogin = DateTime(2025, 1, 3, 9, 45);

Future<void> pumpWidgetWithOverrides(
  WidgetTester tester, {
  required Widget child,
  required StackRouter mockRouter,
  required List<Override> overrides,
}) async {
  tester.view.physicalSize = designSize;
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: ScreenUtilInit(
        designSize: designSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder:
            (context, build) => StackRouterScope(
              controller: mockRouter,
              stateHash: 0,
              child: MaterialApp(home: build),
            ),
        child: child,
      ),
    ),
  );
}
