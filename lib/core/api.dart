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

String getCustomersApi({required int branchId, required int customerType}){
  return "${baseUrl}admin/$branchId/$customerType/customers";
}
String createCustomerApi({required int branchId}){
  return "${baseUrl}admin/$branchId/customer/create";
}

String updateCustomerApi({required int branchId,required int customerId}){
  return "${baseUrl}admin/$branchId/customer/$customerId/update";
}

String deleteCustomerApi({required int branchId,required int customerId}){
  return "${baseUrl}admin/$branchId/customer/$customerId/delete";
}