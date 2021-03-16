import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:YOURDRS_FlutterAPP/common/app_colors.dart';
import 'package:YOURDRS_FlutterAPP/common/app_log_helper.dart';
import 'package:YOURDRS_FlutterAPP/common/app_strings.dart';
import 'package:YOURDRS_FlutterAPP/data/repo/local/db/db_helper.dart';
import 'package:YOURDRS_FlutterAPP/network/models/photo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class ViewImages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ViewImagesState();
  }
}

class ViewImagesState extends State {
  bool isLoadingPath = false;
  int gIndex;
  String directory;
  PhotoList photoList;
  String items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text("Uploaded images"),
        ),
        body: Container(
            child: FutureBuilder<List<PhotoList>>(
                future: DatabaseHelper.db.getAllImages(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PhotoList>> snapshot) {
                  try {
                    if (snapshot.hasData) {
                      return ListView(children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomizedColors.homeSubtitleColor,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.zero),
                          ),
                          child: Builder(
                              builder: (BuildContext context) =>
                              isLoadingPath
                                  ? Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: const CircularProgressIndicator())
                                  : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  PhotoList item = snapshot.data[index];
                                  return GestureDetector(
                                    child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      height: 130,
                                      width: 150,
                                      color: CustomizedColors
                                          .homeSubtitleColor,
                                      child: Image.file(
                                        File('${item.physicalfilename}'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        items = item.physicalfilename;
                                        gIndex = index;
                                      });

                                    },
                                  );
                                },
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          margin: const EdgeInsets.only(
                              left: 0.0, top: 30, right: 0, bottom: 0),
                          child: Image.file(
                            File(items == null ? "" : items),
                            fit: BoxFit.fill,
                          ),
                        )
                      ]);
                    }
                  } on PlatformException catch (e) {
                    print(AppStrings.filePathNotFound + e.toString());
                  }
                })));
  }
}
