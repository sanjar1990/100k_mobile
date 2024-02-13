class EmailVerificationModel{
  final String newEmail;
  final String verificationCode;
  final String password;

  EmailVerificationModel({required this.newEmail, required this.verificationCode, required this.password});
  Map<String, String> toJson(){
    return {
      "email":newEmail,
      "password":password,
      "code":verificationCode
    };
  }
}