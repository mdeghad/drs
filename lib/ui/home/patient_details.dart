import 'dart:convert';
import 'dart:io';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_log_helper.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/db/db_helper.dart';
import 'package:YOURDRS_FlutterAPP/network/models/dictation.dart';
import 'package:YOURDRS_FlutterAPP/network/models/external_attachment.dart';
import 'package:YOURDRS_FlutterAPP/network/models/photo_list.dart';
import 'package:YOURDRS_FlutterAPP/network/models/schedule.dart';
import 'package:YOURDRS_FlutterAPP/ui/home/view_images.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/material_buttons.dart';
import 'package:YOURDRS_FlutterAPP/widget/buttons/raised_buttons.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PatientDetail extends StatefulWidget {
  @override
  // final List<Patient> todos;

  // PatientDetail({Key key, @required this.todos}) : super(key: key);
  _PatientDetailState createState() => _PatientDetailState();
}

class _PatientDetailState extends State<PatientDetail> {
  // Map arguments = Map();
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   arguments = ModalRoute.of(context).settings.arguments;
  // }

  bool widgetVisible = false;
  bool visible = false;
  Directory directory;
  bool isSwitched = false;
  File newImage, image;
  String fileName;
  String filepath;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;
  bool imageVisible = true;
  var imageName;
  int imageIndex = 0;
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat(AppStrings.dateFormat);
  int Id;

  //function to open camera
  Future openCamera() async {
    image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    String path = image.path;
    createFileName(path);

    setState(() {
      // imageArray.add(image);
      image;
      widgetVisible = true;
      visible = false;
    });
  }

  //function to open gallery
  Future openGallery() async {
    setState(() => isLoadingPath = true);
    try {
      if (!isMultiPick) {
        filepath = null;
        paths = await FilePicker.getMultiFilePath(
            type: fileType != null ? fileType : FileType.image,
            allowedExtensions: extensions,
            allowCompression: true);
        print(paths.toString());
      } else {
        filepath = await FilePicker.getFilePath(
            type: fileType != null ? fileType : FileType.image,
            allowedExtensions: extensions,
            allowCompression: true);
        print(filepath);
        paths = null;
      }
    } on PlatformException catch (e) {
      print(AppStrings.filePathNotFound + e.toString());
    }
    try {
      if (!mounted) return;
      setState(() {
        isLoadingPath = false;
        fileName = filepath != null
            ? filepath.split('/').last
            : paths != null
                ? paths.keys.toString()
                : '...';
        visible = true;
        widgetVisible = false;
      });
    } on PlatformException catch (e) {
      print(AppStrings.filePathNotFound + e.toString());
    }
  }

  //custom file name
  Future<String> createFileName(String mockName) async {
    final String formatted = formatter.format(now);
    try {
      imageName = '' + basename(mockName).replaceAll(".", "");
      if (imageName.length > 10) {
        imageName = imageName.substring(0, 10);

        final Directory directory = await getExternalStorageDirectory();
        String path = '${directory.path}/${AppStrings.folderName}';
        final myImgDir = await Directory(path).create(recursive: true);
        newImage = await File(image.path).copy(
            '${myImgDir.path}/${basename(imageName + '${formatted}' + AppStrings.imageFormat)}');
        setState(() {
          newImage;
          print(path);
        });
      }
    } catch (e, s) {
      imageName = "";
      AppLogHelper.printLogs(e, s);
    }
    return "${formatted}" + imageName + AppStrings.imageFormat;
  }

  //function for switch button
  void toggleSwitch(bool value) {
    try {
      if (isSwitched == false) {
        setState(() {
          isSwitched = true;
        });
      } else {
        setState(() {
          isSwitched = false;
        });
      }
    } on PlatformException catch (e) {
      throw (e);
    }
  }

   Future<List>getEpisodeId() async {
    return await DatabaseHelper.db.getAllDictation();
    //print("idssss ${Ids}");
  }
  Future<List>getDictations() async {
    return await DatabaseHelper.db.getAllDictations();
    //print("idssss ${Ids}");
  }
  void disPose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    ScheduleList item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "",
            style: TextStyle(color: CustomizedColors.textColor, fontSize: 14.0),
          ),
          backgroundColor: CustomizedColors.primaryColor,
          elevation: 0.2,
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              CustomizedColors.primaryColor,
              CustomizedColors.primaryColor,
              CustomizedColors.primaryColor,
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
                  child: Column(
                    //  crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Hero(
                          transitionOnUserGestures: true,
                          tag: item,
                          child: Transform.scale(
                            scale: 2.0,
                            child: CircleAvatar(
                              radius: 18,
                              child: ClipOval(
                                child: Image.network(AppStrings.defaultImage),
                              ),
                            ),
                          ),
                        ),
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.patient?.displayName ?? "",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      item.patient?.sex ?? "",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    Text(",",
                                        style: TextStyle(color: Colors.white)),
                                    Text(
                                      item.patient?.age.toString() +
                                              AppStrings.yearOld ??
                                          "",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ],
                                ),
                                Text(
                                  item.accidentDate ?? "",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.dateOfbirth +
                                        ":" +
                                        item.patient?.dob ??
                                    "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                AppStrings.caseNo +
                                        ":" +
                                        item.patient?.accountNumber ??
                                    "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              Text(
                                AppStrings.dos + ":" + item.patient?.dob ?? "",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Button for mic
                                MaterialButtons(
                                  onPressed: () {},
                                  iconData: Icons.mic,
                                ),
                                //
                                //Button for camera
                                MaterialButtons(
                                    onPressed: () {
                                      // CupertinoActionSheet for camera and gallery
                                      cupertinoActionSheet(context);
                                    },
                                    iconData: Icons.camera_alt)
                              ],
                            ),

                            //view camera image
                            Visibility(
                              visible: widgetVisible,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Wrap(children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: CustomizedColors
                                                    .homeSubtitleColor,
                                              ),
                                            ),
                                            height: 100,
                                            child: Container(
                                                margin: const EdgeInsets.all(5),
                                                child: Stack(children: [
                                                  image == null
                                                      ? Text(AppStrings
                                                          .noImageSelected)
                                                      : Image.file(
                                                          image,
                                                          fit: BoxFit.contain,
                                                        ),
                                                  Positioned(
                                                    right: -10,
                                                    top: -5,
                                                    child: Visibility(
                                                      visible: imageVisible,
                                                      child: IconButton(
                                                        icon: new Icon(
                                                          Icons.close,
                                                          color: CustomizedColors
                                                              .signInButtonTextColor,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            image = null;
                                                            imageVisible =
                                                                false;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ]))),
                                      ]),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RaisedBtn(
                                          text: AppStrings.submitImages,
                                          onPressed: () async {
                                            final String formatted =
                                                formatter.format(now);
                                            List id=await getEpisodeId();
                                            print(getEpisodeId());
                                            int index;
                                           // print("episod id ${id[index++].episodeId}");
                                           // for(int i=0;i<id.length;index++) {
                                             print("epid......." + '${item.episodeId}');

                                             if (id[0].episodeId == item.episodeId &&
                                                 id[1].appointmentId == item
                                                     .episodeAppointmentRequestId) {
                                               // await getDictations();
                                               print(("object......"));
                                               List eId = await DatabaseHelper
                                                   .db
                                                   .getAllDictations();
                                               Id = eId[0].id;
                                               print("/////////$Id");
                                             }
                                             else if (id[0].episodeId == null &&
                                                 id[1].appointmentId == null)
                                             {
                                               await DatabaseHelper.db
                                                   .insertAudio(Dictation(
                                                 patientFirstName:
                                                 '${item.patient.firstName ??
                                                     ''}',
                                                 patientLastName:
                                                 '${item.patient.lastName ??
                                                     ''}',
                                                 providerName:
                                                 '${item.patient.providerName ??
                                                     ''}',
                                                 providerId:
                                                 item.providerId ?? '',
                                                 patientDOB:
                                                 '${item.patient.dob ?? ''}',
                                                 appointmentdate:
                                                 '${item.appointmentStartDate ??
                                                     ''}',
                                                 episodeId: item.episodeId,
                                                 appointmentTypeId: item
                                                     .appointmentTypeId,
                                                 appointmentId: item
                                                     .episodeAppointmentRequestId ??
                                                     '',
                                                 practiceName: "${item
                                                     .practice ?? ''}",
                                                 practiceId: item.practiceId ??
                                                     '',
                                               ));
                                               List eId = await DatabaseHelper
                                                   .db
                                                   .getAllDictations();
                                               Id = eId[3].id;
                                               print(
                                                   "\\\\\\\\\\\\/////////$Id");

                                               await DatabaseHelper.db
                                                   .insertPhotoList(
                                                   PhotoList(
                                                       dictationLocalId: Id,
                                                       //  fileName: '${item.scheduleName??''}',
                                                       attachmentname:
                                                       '${item.patient
                                                           .displayName ??
                                                           ''}_ ${formatted}_${basename(
                                                           '${image}')}',
                                                       createddate:
                                                       '${DateTime
                                                           .now()}',
                                                       attachmenttype:
                                                       AppStrings
                                                           .imageFormat,
                                                       physicalfilename:
                                                       '${image
                                                           .path}'));
                                             }
                                          // }

                                            setState(() {
                                              widgetVisible = false;
                                              visible = false;
                                            });
                                          },
                                          iconData: Icons.image)
                                    ]),
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            //view gallery images
                            Visibility(
                                visible: visible,
                                child: Column(children: [
                                  Builder(
                                    builder: (BuildContext context) =>
                                        isLoadingPath
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child:
                                                    const CircularProgressIndicator())
                                            : filepath != null ||
                                                    (paths != null &&
                                                        paths.values != null &&
                                                        paths.values.isNotEmpty)
                                                ? new Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: CustomizedColors
                                                            .homeSubtitleColor,
                                                      ),
                                                    ),
                                                    //   padding: const EdgeInsets.only(bottom: 30.0),
                                                    height: 100,
                                                    child:
                                                        new ListView.separated(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: paths !=
                                                                  null &&
                                                              paths.isNotEmpty
                                                          ? paths.length
                                                          : 1,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final bool isMultiPath =
                                                            paths != null &&
                                                                paths
                                                                    .isNotEmpty;
                                                        final filePath1 =
                                                            isMultiPath
                                                                ? paths.values
                                                                    .toList()[
                                                                        index]
                                                                    .toString()
                                                                : filepath;
                                                        print(filePath1);
                                                        return Container(
                                                          color: CustomizedColors
                                                              .homeSubtitleColor,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child:
                                                              Stack(children: [
                                                            filePath1 != null
                                                                ? Image.file(
                                                                    File(
                                                                        filePath1),
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )
                                                                : Container(),
                                                            Positioned(
                                                              right: -10,
                                                              top: -5,
                                                              child: IconButton(
                                                                icon: new Icon(
                                                                  Icons.close,
                                                                  color: CustomizedColors
                                                                      .signInButtonTextColor,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    imageIndex =
                                                                        index;
                                                                    // paths.values.toList().removeAt(index);
                                                                    imageName =
                                                                        basename(paths
                                                                            .values
                                                                            .toList()[index]);
                                                                    paths.remove(
                                                                        imageName);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ]),
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (BuildContext context,
                                                                  int index) =>
                                                              new Divider(),
                                                    ),
                                                  )
                                                : new Container(
                                                    child: Text(AppStrings
                                                        .noImageSelected),
                                                  ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  //save gallery images to sqlite
                                  RaisedBtn(
                                      text: AppStrings.submitImages,
                                      onPressed: () async {
                                        final String formatted =
                                            formatter.format(now);

                                        for (int i = 0;
                                            i < paths.keys.toList().length;
                                            imageIndex++) {
                                          // DatabaseHelper.db.insertPhotoList(
                                          //     PhotoList(
                                          //         // dictationLocalId:
                                          //         //     '',
                                          //         attachmentname:
                                          //             '${item.patient.displayName ?? ''}' +
                                          //                 "_" +
                                          //                 '${formatted}' +
                                          //                 '_' +
                                          //                 ('${paths.keys.toList()[imageIndex]}'),
                                          //         attachmenttype:
                                          //             AppStrings.imageFormat,
                                          //         // "_" +
                                          //         // AppStrings.imageFormat,
                                          //         createddate:
                                          //             '${DateTime.now()}',
                                          //         physicalfilename:
                                          //             '${paths.values.toList()[imageIndex]}'));

                                          setState(() {
                                            widgetVisible = false;
                                            visible = false;
                                          });
                                        }
                                      },
                                      iconData: Icons.image),
                                ])),

                            SizedBox(
                              height: 15,
                            ),

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RaisedBtn(
                                      text: AppStrings.superBill,
                                      onPressed: () {},
                                      iconData: Icons.description_outlined),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RaisedBtn(
                                      text: AppStrings.allDictations,
                                      onPressed: () {
                                        DatabaseHelper.db.deleteAllDictations();
                                      },
                                      iconData: Icons.mic_rounded),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RaisedBtn(
                                      text: AppStrings.images,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewImages()));
                                      },
                                      iconData: Icons.camera_alt),
                                ]),

                            SizedBox(
                              height: 15,
                            ),
                            Row()
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }

  Widget cupertinoActionSheet(BuildContext context) {
    final action = CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.camera),
            ],
          ),
          onPressed: () {
            openCamera();
            Navigator.pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.PhotoGallery),
            ],
          ),
          onPressed: () {
            //loadAssets();

            openGallery();
            Navigator.pop(context);
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(AppStrings.cancel),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    showCupertinoModalPopup(context: context, builder: (context) => action);
  }
}
