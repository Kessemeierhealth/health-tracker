import 'package:flutter_test/flutter_test.dart';
import 'package:healthtracker/app/app.dart';

void main() {
  testWidgets('HealthTracker startet ohne Fehler', (WidgetTester tester) async {
    await tester.pumpWidget(const HealthTrackerApp());
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}