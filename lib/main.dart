import 'package:flutter/material.dart';
import 'core/data_source/supabase_data_source.dart';
import 'core/di/locator.dart';
import 'core/network/api_service.dart';
import 'food_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SubabaseDataSource.init();
  setupLocator();
  ApiService;
  runApp(const FoodApp());
}


