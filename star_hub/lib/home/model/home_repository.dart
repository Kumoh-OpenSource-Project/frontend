import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:star_hub/common/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:star_hub/home/model/home_entity.dart';

part 'home_repository.g.dart';

final homeRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return HomeRepository(dio);
});

@RestApi()
abstract class HomeRepository {
  factory HomeRepository(Dio dio, {String? baseUrl}) = _HomeRepository;

  @GET('home?type=today&lat={lat}&lon={lon}')
  @Headers({'accessToken': 'true'})
  Future<TodayWeatherData> getTodayData(@Path('lat') double lat, @Path('lon') double lon);

  @GET('home?type=current&lat={lat}&lon={lon}')
  @Headers({'accessToken': 'true'})
  Future<RealTimeWeatherInfo> getRealTimeData(@Path('lat') double lat, @Path('lon') double lon);

  @GET('home?type=week&lat={lat}&lon={lon}')
  @Headers({'accessToken': 'true'})
  Future<List<WeatherData>> getWeekData(@Path('lat') double lat, @Path('lon') double lon);


  @GET('home/moon?year={year}&month={month}')
  @Headers({'accessToken': 'true'})
  Future<List<LunarData>> getLunarData(@Path("year") String year, @Path("month") String month);
}
