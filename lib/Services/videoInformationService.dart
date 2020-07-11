import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:school_flix_flutter/Models/videoInformation.dart';
import 'package:school_flix_flutter/Network/apiResponce.dart';
import 'package:school_flix_flutter/util/constents.dart';

class VideoInformationService {
  VideoInformation videoInformation;
  Future<APIResponce<VideoInformation>> getVedioInformationList(
      int maxResul) async {
    var data = await http.get(Constents.youtubeApi);
    if (data != null) {
      if (data.statusCode == 200) {
        final jsonDataasMap = json.decode(data.body);
        print("responce body in videoInformation service : ${jsonDataasMap}");
        videoInformation =
            VideoInformation.fromJson(jsonDataasMap);

        print(" image urls inn services  +++++++++++++++++++ ${videoInformation.items[1].snippet.thumbnails.medium.url}");

        // videoInformationListItems = <VideoInformation>[];
        // for (int i = 0; i < videoInformation.items.length; i++ ) {
        //   VideoInformation videoInformation =
        //       VideoInformation.fromJson(videoInformation.items[i]);
        //   print("${videoInformation.etag}");
        //   print("${videoInformation.kind}");
        //   print("${videoInformation.pageInfo}");
        //   print("${videoInformation.nextPageToken}");

        //   videoInformationListItems.add(videoInformation);
        // }

        return APIResponce<VideoInformation>(data: videoInformation);
      }

      return APIResponce<VideoInformation>(
          error: true,
          data: videoInformation,
          errorMessage:
              "An error occured in videoInformation service class !!!!!");
    }
    return APIResponce<VideoInformation>(
        error: true,
        data: videoInformation,
        errorMessage:
            "An error occured in videoInformation service class !!!!!");
  }
}
