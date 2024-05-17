String baseUrl = "https://skill-test.retinasoft.com.bd/api/v1/";

String businessTypesApi = "${baseUrl}get-business-types";
String registrationApi = "${baseUrl}sign-up/store";
String registrationOtpApi = "${baseUrl}sign-up/verify-otp-code";
String reSendOtpApi = "${baseUrl}sign-up/send-otp-code";

String loginOtpApi = "${baseUrl}send-login-otp";
String loginApi = "${baseUrl}login";

String getBranchesApi = "${baseUrl}admin/branches";
String createBranchApi = "${baseUrl}admin/branch/create";
String deleteBranchApi(int id){
  return "${baseUrl}admin/branch/$id/delete";
}
String updateBranchApi(int id){
  return "${baseUrl}admin/branch/$id/update";
}

