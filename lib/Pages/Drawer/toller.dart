
import 'package:rsapp/Pages/History/history_page.dart';
import 'package:rsapp/Pages/Home/home_page.dart';
import 'package:rsapp/Pages/Login/login_page.dart';
import 'package:rsapp/Pages/Registration/Registration.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
<String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomePage>(() => HomePage());
    register<RegistrationPage>(() => RegistrationPage());
    register<HistoryPage>(() => HistoryPage());
    register<LoginPage>(() => LoginPage());
  }

  static fromString(String s) {}


}