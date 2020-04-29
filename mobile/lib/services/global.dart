import 'package:mobile/model/user.dart';
import 'package:mobile/services/database.dart';

class Global {
  static final String title = 'Vera - ChatBot';

  static final Map models = {
    User: (data) => User.fromMap(data),
  };

  // Firestore References
  static final UserData<User> userRef = UserData<User>(collection: 'user');
}
