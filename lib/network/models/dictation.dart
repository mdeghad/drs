import 'dart:typed_data';

import 'package:YOURDRS_FlutterAPP/network/models/photo_list.dart';

class Dictation {
  int id;
  Uint8List audioFile;
  String dictationId;
  int episodeId;
  String attachmentName;
  int attachmentSizeBytes;
  String attachmentType;
  int memberId;
  int statusId;
  bool uploadedToServer;
  String createdDate;
  String displayFileName;
  String fileName; //name of the audio file
  String physicalFileName; //path
  String patientFirstName;
  String patientLastName;
  String patientDOB;
  String dos;
  int practiceId;
  String practiceName;
  int locationId;
  String locationName;
  int providerId;
  String providerName;
  int appointmentTypeId;
  int appointmentId;
  String appointmentdate;
 PhotoList photoList;

  // String CPTCodeIds;
  String dictationTypeId;
  bool isEmergencyAddOn;
  int externalDocumentTypeId;
  String description;
  String appointmentProvider;
  bool isSelected;

  Dictation(
      {this.id,
      this.audioFile,
      this.dictationId,
      this.episodeId,
      this.attachmentName,
      this.attachmentSizeBytes,
      this.attachmentType,
      this.memberId,
      this.statusId,
      this.uploadedToServer,
      this.createdDate,
      this.displayFileName,
      this.fileName,
      this.physicalFileName,
      this.patientFirstName,
      this.patientLastName,
      this.patientDOB,
      this.dos,
      this.practiceId,
      this.practiceName,
      this.locationId,
      this.locationName,
      this.providerId,
      this.providerName,
      this.appointmentTypeId,
      this.appointmentId,
        this.appointmentdate,
     this.photoList,
      this.dictationTypeId,
      this.isEmergencyAddOn,
      this.externalDocumentTypeId,
      this.description,
      this.appointmentProvider,
      this.isSelected});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'audioFile': audioFile,
      'dictation_id': dictationId,
      'episode_id': episodeId,
      'attachmentName': attachmentName,
      'attachmentSizeBytes': attachmentSizeBytes,
      'attachmentType': attachmentType,
      'memberId': memberId,
      'statusId': statusId,
      'uploadedToServer': uploadedToServer,
      'createdDate': createdDate,
      'displayFileName': displayFileName,
      'fileName': fileName,
      'physicalFileName': physicalFileName,
      'patientFirstName': patientFirstName,
      'patientLastName': patientLastName,
      'patientDOB': patientDOB,
      'DOS': dos,
      'practiceId': practiceId,
      'practiceName': practiceName,
      'locationId': locationId,
      'locationName': locationName,
      'providerId': providerId,
      'providerName': providerName,
      'appointmentTypeId': appointmentTypeId,
     'photoList':photoList,
      // 'CPTCodeIds':CPTCodeIds,
      'dictationTypeId': dictationTypeId,
      'isEmergencyAddOn': isEmergencyAddOn,
      'externalDocumentTypeId': externalDocumentTypeId,
      'appointmentId': appointmentId,
      'appointmentdate':appointmentdate,
      'description': description,
      'appointmentProvider': appointmentProvider,
      'isSelected': isSelected
    };
    return map;
  }

  Dictation.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    audioFile = map['audioFile'];
    dictationId = map['dictation_id'];
    episodeId = map['episode_id'];
    attachmentName = map['attachmentName'];
    attachmentSizeBytes = map['attachmentSizeBytes'];
    attachmentType = map['attachmentType'];
    memberId = map['memberId'];
    statusId = map['statusId'];
    uploadedToServer = map['uploadedToServer'];
    createdDate = map['createdDate'];
    displayFileName = map['displayFileName'];
    fileName = map['fileName'];
    physicalFileName = map['physicalFileName'];
    patientFirstName = map['patientFirstName'];
    patientLastName = map['patientLastName'];
    patientDOB = map['patientDOB'];
    dos = map['DOS'];
    practiceId = map['practiceId'];
    practiceName = map['practiceName'];
    locationId = map['locationId'];
    locationName = map['locationName'];
    providerId = map['providerId'];
    providerName = map['providerName'];
    appointmentTypeId = map['appointmentTypeId'];
    appointmentdate=map['appointmentdate'];
   photoList=map['photoList'];
    // CPTCodeIds = map['CPTCodeIds'];
    dictationTypeId = map['dictationTypeId'];
    isEmergencyAddOn = map['isEmergencyAddOn'];
    externalDocumentTypeId = map['externalDocumentTypeId'];
    description = map['description'];
    appointmentProvider = map['appointmentProvider'];
    isSelected = map['isSelected'];
  }
  String toString() {
    return toMap().toString();
  }
  // List<Object> get props => [
  //   this.locationId,
  //   this.locationName,
  //   this.memberId,
  // ];
}
