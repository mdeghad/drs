import 'dart:convert';
import 'package:YOURDRS_FlutterAPP/common/app_constants.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';
import 'package:YOURDRS_FlutterAPP/network/models/location.dart';
import 'package:YOURDRS_FlutterAPP/network/models/provider.dart';
import 'package:YOURDRS_FlutterAPP/network/models/schedule.dart';
// import 'package:YOURDRS_FlutterAPP/network/models/schedule_list.dart';

import 'package:http/http.dart' as http;

class Services {
  static const String url = 'https://jsonplaceholder.typicode.com/users';

//getUsers service method
  static Future<List<Patients>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<Patients> list = parseUsers(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Patients> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Patients>((json) => Patients.fromJson(json)).toList();
  }

  static Future<List<ScheduleList>> getSchedule(
      String date,
      int providerId,
      int locationId,
      int dictationId,
      String startDate,
      String endDate,
      String searchString) async {
    String apiUrl = ApiUrlConstants.getSchedules;
    DateTime defaultDate = DateTime.now();
    var todayDate = AppConstants.parseDate(-1, AppConstants.MMDDYYYY,
        dateTime: defaultDate);
    final json = {
      "memberId": 1,
      "appointmentStartDate": startDate != null
          ? startDate
          : date == null
              ? todayDate
              : date,
      "appointmentEndDate": endDate != null
          ? endDate
          : date == null
              ? todayDate
              : date,
      "locationId": locationId ?? null,
      "patientSearchString": searchString ?? null,
      "dictationStatusId": dictationId ?? null,
      "providerId": providerId ?? null,
      "page": 1
    };
    print(json);
    http.Response response = await http.post(
      apiUrl,
      body: jsonEncode(json),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Schedule schedule =
          Schedule.fromJson(jsonDecode(response.body.toString()));
      return schedule.scheduleList;
    } else {
      throw Exception("Error");
    }
  }

  //getLocation service method//

  Future<Locations> getLocation() async {
    try {
      var endpointUrl = ApiUrlConstants.getLocation;
      Map<String, String> queryParams = {
        'MemberId': '1',
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      final response = await http.get(Uri.encodeFull(requestUrl),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        Locations location = parseLocation(response.body);
        // print(list);
        return location;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Locations parseLocation(String responseBody) {
    final Locations location = Locations.fromJson(json.decode(responseBody));
    return location;
  }

//getProviders service
  Future<Providers> getProviders() async {
    try {
      var endpointUrl = ApiUrlConstants.getProviders;
      Map<String, String> queryParams = {
        'MemberId': '1',
      };
      String queryString = Uri(queryParameters: queryParams).query;
      var requestUrl = endpointUrl + '?' + queryString;
      final response = await http.get(Uri.encodeFull(requestUrl),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        Providers provider = parseProviders(response.body);
        // print(list);
        return provider;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Providers parseProviders(String responseBody) {
    final Providers provider = Providers.fromJson(json.decode(responseBody));
    return provider;
  }
}
