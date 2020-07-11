import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:school_flix_flutter/Models/videoInformation.dart';
import 'package:school_flix_flutter/Network/apiResponce.dart';
import 'package:school_flix_flutter/Services/videoInformationService.dart';
import 'package:school_flix_flutter/util/appTheme.dart';
import 'package:school_flix_flutter/util/networkConnectivity.dart';
import 'package:school_flix_flutter/commonWidgets..dart';
import 'package:school_flix_flutter/Screens/PlayerScreen/playerScreen.dart';

class VideoScreenHome extends StatefulWidget {
  @override
  _VideoScreenHomeState createState() => _VideoScreenHomeState();
}

class _VideoScreenHomeState extends State<VideoScreenHome> {
  VideoInformationService get videoInformationService =>
      GetIt.I<VideoInformationService>();

  APIResponce<VideoInformation> apiResponce;

  bool isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  //Scroll controller for lazy loading
  ScrollController lazyListscrollController = ScrollController();

  bool _isLoading = false;
  bool isNewLoader = true;

  bool _hasMore = true;
  int maxResult = 50;

  @override
  void initState() {
    // TODO: implement initState

    //callinf main data functon for this screen
    netWorkChek();
    //_fetchSammury();

    super.initState();
  }

  netWorkChek() async {
    await NetworkConnectivity.check().then((internet) async {
      // clear past user

      if (internet) {
        _getDoListData();
      } else {
        //show network erro
        // showMessageError("Network is not avalable !!!");
      }
    });
  }

  // void showMessageSuccess(String message, [MaterialColor color = Colors.blue]) {
  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(
  //     backgroundColor: color,
  //     content: new Text(
  //       message,
  //       style: TextStyle(fontWeight: FontWeight.w700),
  //     ),
  //     duration: const Duration(seconds: 2),
  //   ));
  // }

  // void showMessageError(String message, [MaterialColor color = Colors.red]) {
  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(
  //     backgroundColor: color,
  //     content: new Text(
  //       message,
  //       style: TextStyle(fontWeight: FontWeight.w700),
  //     ),
  //     duration: const Duration(seconds: 2),
  //   ));
  // }

// fetching the Dashboard data
  _getDoListData() async {
    setState(() {
      isLoading = true;
    });

    apiResponce =
        await videoInformationService.getVedioInformationList(maxResult);

    if (apiResponce == null) {
      setState(() {
        isLoading = false;
      });
      // showMessageError("Something went wrong !!!");
      // print(" ${apiResponce.errorMessage}");
    } else if (apiResponce.error) {
      setState(() {
        isLoading = false;
      });
      // showMessageError("Something went wrong !!!");
    }
// print("${apiResponce.data.apr}");
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.background,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () {
            return netWorkChek();
          },
          child: Builder(
            builder: (BuildContext context) {
              if (isLoading) {
                return CommonWidgets.progressIndicator;
              }

              if (apiResponce == null || apiResponce.data.items.length == 0) {
                // showMessageError("Something went wrong");
                return InkWell(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Noting here",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tap to reload",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  )),
                  onTap: () {
                    netWorkChek();
                  },
                );
              }

              return _bodyWidget();
            },
          ),
        ));
  }

  Widget _bodyWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 2.0),
        child: ListView.builder(
            key: UniqueKey(),
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            // controller: lazyListscrollController,
            //  itemCount: globalItemsList.data.length,

            itemCount: apiResponce.data.items.length,
            itemBuilder: (BuildContext context, int index) {
              // Items thisListItems = globalItemsList
              //  .data[index];
              // (snapshot.data[snapshot.data.length - index].title);
              //  if (index == globalItemsList.data.length - 1) {
              // print("length matched");
              // return Padding(
              //   padding: const EdgeInsets.only(bottom: 18.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       SizedBox(
              //         width: 18,
              //         height: 18,
              //         child: CircularProgressIndicator(
              //           strokeWidth: 2.5,
              //         ),
              //       ),

              //     ],
              //   ),
              // );
              //  }
              //  else{

              // return dOListCardState(apiResponce.data[index]);

              // return DOListCard(
              //   deliveryOrder: apiResponce.data[index],
              // );
              // return Text("${apiResponce.data.items[index].snippet.title}");
              return listViewCard(apiResponce.data.items[index]);
            }
            //   },

            ),
      ),
    );
  }

  Widget listViewCard(Item item) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 0.0),
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  height: 200,

                  // decoration: BoxDecoration(color: Colors.amber),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: item.snippet.thumbnails.medium.url,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          //           border: Border.all(
                          //   color: Colors.blue,
                          //   width: 0.5,
                          // ),
                          // shape: BoxShape.rectangle,

                          //  borderRadius: BorderRadius.circular(500),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //     Colors.black12, BlendMode.colorBurn)
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 14,
                              width: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              )),
                        ],
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 8,right:5,bottom: 15),
                  child: Text(
                    "${item.snippet.title}",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 8,
              // )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerScreen(
                      item: item,
                    )));
      },
    );
  }
}
