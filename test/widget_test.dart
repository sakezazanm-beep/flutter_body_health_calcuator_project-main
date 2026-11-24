import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_body_health_calculator_project/views/bmi_ui.dart';
import 'package:flutter_body_health_calculator_project/views/bmr_ui.dart';

void main() {
  testWidgets('BMI button calculates and clear button resets the result', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BmiUI()));

    await tester.enterText(find.byType(TextField).at(0), '70');
    await tester.enterText(find.byType(TextField).at(1), '175');
    await tester.tap(find.text('คำนวณ BMI'));
    await tester.pump();

    expect(find.text('22.86'), findsOneWidget);
    expect(find.text('น้ำหนักอยู่ในเกณฑ์ปกติ'), findsOneWidget);

    await tester.tap(find.text('ล้างข้อมูล'));
    await tester.pump();

    expect(find.text('0.00'), findsOneWidget);
    expect(find.text('การแปรผล'), findsOneWidget);
  });

  testWidgets('BMR button calculates based on selected gender', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: BmrUI()));

    await tester.enterText(find.byType(TextField).at(0), '70');
    await tester.enterText(find.byType(TextField).at(1), '175');
    await tester.enterText(find.byType(TextField).at(2), '30');
    await tester.ensureVisible(find.text('คำนวณ BMR'));
    await tester.tap(find.text('คำนวณ BMR'));
    await tester.pump();

    expect(find.text('1648.75'), findsOneWidget);

    await tester.ensureVisible(find.text('หญิง'));
    await tester.tap(find.text('หญิง'));
    await tester.ensureVisible(find.text('คำนวณ BMR'));
    await tester.tap(find.text('คำนวณ BMR'));
    await tester.pump();

    expect(find.text('1482.75'), findsOneWidget);
  });
}
