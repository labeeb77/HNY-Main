class Validators {
   static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }else if(value.length < 9){
      return 'Phone number must be at least 10 characters long';
    }
    return null;
  }


  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}
