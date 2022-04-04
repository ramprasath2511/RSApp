import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rsapp/Pages/Login/login_page.dart';

void main() {
  Widget testableWidget({ Widget? child}){
    return MaterialApp(
      home: child,
    );
  }
  testWidgets('Login_test', (WidgetTester tester) async {
    LoginPage page = LoginPage();
    await tester.pumpWidget(testableWidget(child:page));
    final emailTextField = find.byKey(ValueKey("login_email"));
    final passwordTextField = find.byKey(ValueKey("password"));
    final submit = find.byKey(ValueKey("submit"));
    var textField = find.byType(TextField);
    expect(textField, findsNWidgets(2));
    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(emailTextField, 'ramprasath@gmail.com');
    await tester.enterText(passwordTextField, 'Sharmila@2511');
    expect(find.text('ramprasath@gmail.com'),findsOneWidget);
    expect(find.text('Sharmila@2511'),findsOneWidget);
    print('ramprasath@gmail.com');
    var button= find.text("SIGN IN");
    expect(button,findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(submit, findsNothing);



  }
  );
}