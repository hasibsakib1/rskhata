import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api.dart';
import '../model/business_type_model.dart';
import '../../../main.dart';

final businessTypeProvider = StateNotifierProvider<BusinessTypeNotifier, List<BusinessTypeModel>>((ref) {
  return BusinessTypeNotifier();
});

class BusinessTypeNotifier extends StateNotifier<List<BusinessTypeModel>> {
  BusinessTypeNotifier(): super([]);
  
  void fetchBusinessTypes() async{
    try{
      final response = await dio.get(businessTypesApi);
      if(response.statusCode == 200){
        log.i(response.data);
        final data = response.data['business_types'];
        final businessTypes = data.map<BusinessTypeModel>((e) => BusinessTypeModel.fromJson(e)).toList();
        state = businessTypes;
      }
      else{
        throw Exception('Failed to load business types');
      }
    }
    catch(e){
      log.e(e);
    }
  }
}