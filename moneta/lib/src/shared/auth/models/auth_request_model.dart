import 'package:string_validator/string_validator.dart' as validator;

class AuthRequestModel {
  UserName _userName = UserName('');
  void setUserName(String newUserName) => _userName = UserName(newUserName);
  UserName get userName => _userName;

  Password _password = Password('');
  void setPassword(String newPassword) => _password = Password(newPassword);
  Password get password => _password;

  String? validate() {
    String? validate = _userName.validate();
    if (validate != null) {
      return validate;
    }

    validate = _password.validate();
    if (validate != null) {
      return validate;
    }
    return null;
  }
}

class UserName {
  final String value;

  UserName(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo usuário é obrigatório";
    }
    return null;
  }
}

class Password {
  final String value;

  Password(this.value);

  String? validate() {
    if (value.isEmpty) {
      return "Campo senha é obrigatório";
    }
    if(!validator.isLength(value, 6)) {
      return "Senha deve ter no mínimo de 6 caracteres";
    }
    return null;
  }
}
