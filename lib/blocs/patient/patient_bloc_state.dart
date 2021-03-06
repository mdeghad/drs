import 'package:YOURDRS_FlutterAPP/blocs/base/base_bloc_state.dart';
import 'package:YOURDRS_FlutterAPP/network/models/appointment.dart';
import 'package:YOURDRS_FlutterAPP/network/models/schedule.dart';

class PatientAppointmentBlocState extends BaseBlocState {
  final bool isLoading;
  final String errorMsg;
  final List<Patients> users;
  final String keyword;
  final String keyword1;
  final int providerId;
  final int locationId;
  final int dictationId;
  final String startDate;
  final String endDate;
  final String searchString;
  final List<ScheduleList> patients;

  factory PatientAppointmentBlocState.initial() => PatientAppointmentBlocState(
        errorMsg: null,
        isLoading: false,
        users: null,
      );

  PatientAppointmentBlocState reset() => PatientAppointmentBlocState.initial();

  PatientAppointmentBlocState(
      {this.isLoading = false,
      this.errorMsg,
      this.users,
      this.keyword,
      this.patients,
      this.keyword1,
      this.providerId,
      this.dictationId,
      this.locationId,
      this.startDate,
      this.endDate,
      this.searchString});

  @override
  List<Object> get props =>
      [this.isLoading, this.errorMsg, this.users, this.keyword, this.patients];

  PatientAppointmentBlocState copyWith(
      {bool isLoading,
      String errorMsg,
      List<Patients> users,
      String keyword,
      String keyword1,
      int providerId,
      int locationId,
      int dictationId,
      String startDate,
      String endDate,
      String searchString,
      List<ScheduleList> patients}) {
    return new PatientAppointmentBlocState(
        isLoading: isLoading ?? this.isLoading,
        errorMsg: errorMsg ?? this.errorMsg,
        users: users ?? this.users,
        keyword: keyword ?? this.keyword,
        keyword1: keyword1 ?? this.keyword1,
        providerId: providerId ?? this.providerId,
        locationId: locationId ?? this.locationId,
        dictationId: dictationId ?? this.dictationId,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        patients: patients ?? this.patients,
        searchString: searchString ?? this.searchString);
  }

  @override
  String toString() {
    return 'PatientAppointmentMainState{isLoading: $isLoading, errorMsg: $errorMsg, users: $users, keyword: $keyword},patients:$patients';
  }
}
