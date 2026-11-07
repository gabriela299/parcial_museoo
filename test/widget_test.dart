import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parcial_museoo/main.dart';
void main() {
  // Pantalla grande para que el GridView construya las 4 tarjetas
  void configurarPantalla(WidgetTester tester) {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('Muestra el título y los 4 museos', (WidgetTester tester) async {
    configurarPantalla(tester);
    await tester.pumpWidget(const MuseosApp());
    await tester.pumpAndSettle();

    expect(find.text('Museos'), findsOneWidget);
    expect(find.text('Museo de Arte del Río'), findsOneWidget);
    expect(find.text('Museo de Historia Natural Andina'), findsOneWidget);
    expect(find.text('Museo Arqueológico del Altiplano'), findsOneWidget);
    expect(find.text('Casa Museo del Patrimonio Local'), findsOneWidget);
  });

  testWidgets('El buscador filtra por nombre', (WidgetTester tester) async {
    configurarPantalla(tester);
    await tester.pumpWidget(const MuseosApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'arte');
    await tester.pumpAndSettle();

    expect(find.text('Museo de Arte del Río'), findsOneWidget);
    expect(find.text('Museo de Historia Natural Andina'), findsNothing);
    expect(find.text('Casa Museo del Patrimonio Local'), findsNothing);
  });
}