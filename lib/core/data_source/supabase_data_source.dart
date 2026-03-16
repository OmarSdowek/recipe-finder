import 'package:supabase_flutter/supabase_flutter.dart';

import '../constant/api_endpoint.dart';

class SubabaseDataSource {

  static Future init()async{
    await Supabase.initialize(
      url: ApiEndpoints.supabaseUrl,
      anonKey: ApiEndpoints.supabaseKey,
    );
  }

}