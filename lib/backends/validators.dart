abstract class BaseValidators {
  String? validateEmpty(String? valu);
  String? validateName(String value);
  String? validateEmail(String value);
  String? validatePassword(String value);
}

class ValidatorsFxn implements BaseValidators {
  @override
  String? validateEmpty(String? value) {
    if (value!.trim().length == 0) {
      return 'Field is Required';
    }
    return null;
  }

  @override
  String? validateName(String? value) {
    if (value!.trim().length == 0) {
      return "Name is Required";
    } else if (value.trim().length < 2) {
      return "Invalid name length";
    }
    return null;
  }

  @override
  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.trim().length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  @override
  String? validatePassword(String? value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.trim().length <= 0) {
      return "Password is Required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Upper,Lower Case, Number and Special chars";
    }
    return null;
  }
}
