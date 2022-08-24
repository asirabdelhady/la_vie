
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/constants/colors.dart';
import 'package:la_vie/presentation/screens/create_post_screen.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';
import '../../business_logic/la_vie_cubit/cubit.dart';
import '../../business_logic/la_vie_cubit/states.dart';
import '../../data/web_services/end_points.dart';

class ForumsScreen extends StatefulWidget {
  const ForumsScreen({Key? key}) : super(key: key);

  @override
  _ForumsScreenState createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  ScrollController parentScrollController = ScrollController();
  ScrollController childScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var cubit = LaVieCubit.get(context);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<LaVieCubit, LaVieStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: parentScrollController,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Column(
                        children: [
                          const Text(
                            'Discussion Forums',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          searchFormFeild(width: double.infinity),
                          const SizedBox(
                            height: 16,
                          ),
                          SingleChildScrollView(
                            controller: childScrollController,
                            child: NotificationListener(
                              onNotification: (ScrollNotification notification){
                                if (notification is ScrollUpdateNotification) {
                                  if (notification.metrics.pixels ==
                                      notification.metrics.maxScrollExtent) {
                                    debugPrint('Reached the bottom');
                                    parentScrollController.animateTo(
                                        parentScrollController.position.maxScrollExtent,
                                        duration: const Duration(milliseconds:300),
                                        curve: Curves.easeIn);
                                  } else if (notification.metrics.pixels ==
                                      notification.metrics.minScrollExtent) {
                                    debugPrint('Reached the top');
                                    parentScrollController.animateTo(
                                        parentScrollController.position.minScrollExtent,
                                        duration: const Duration(milliseconds:300),
                                        curve: Curves.easeIn);
                                  }
                                };
                                return true;
                              },
                              child: DefaultTabController(
                                  initialIndex: 0,
                                  length: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 30,
                                        child: TabBar(
                                          tabs: const [
                                            Text('All Forums'),
                                            Text('My Forums'),
                                          ],
                                          unselectedLabelColor: Colors.grey,
                                          labelColor: Colors.white,
                                          isScrollable: true,
                                          indicatorSize: TabBarIndicatorSize.tab,
                                          indicator: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      if (cubit.seedsModel != null)
                                        Container(
                                          width: double.infinity,
                                          height: mediaQueryHeight,
                                          child: TabBarView(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 16.0),
                                              child: ListView.separated(
                                                  itemCount: 6,
                                                  separatorBuilder: (context, index) =>
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                  itemBuilder: (context, index) =>
                                                      forumCard(
                                                        postDescription: cubit.forumsModel!.data![index].description,
                                                        postImage: cubit.forumsModel!.data![index].imageUrl,
                                                        postTitle: cubit.forumsModel!.data![index].title,
                                                        userImage: cubit.forumsModel!.data![index].user!.imageUrl,
                                                        username: cubit.forumsModel!.data![index].user!.firstName,

                                                      )),
                                            ),
                                            if(cubit.forumsModel!=null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 16.0),
                                              child: ListView.separated(
                                                  itemCount: 6,
                                                  separatorBuilder: (context, index) =>
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                  itemBuilder: (context, index) =>
                                                      forumCard(
                                                        postDescription: cubit.myForumModel!.data![index].description,
                                                        postImage: cubit.myForumModel!.data![index].imageUrl,
                                                        postTitle: cubit.myForumModel!.data![index].title,
                                                        userImage: cubit.myForumModel!.data![index].user!.imageUrl,
                                                        username: cubit.myForumModel!.data![index].user!.firstName,
                                                      ),),
                                            ),
                                          ]),
                                        ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 280,
                  child: FloatingActionButton(
                    onPressed: (){
                      navigateTo(context, const CreatePost());
                    },
                    child: const Icon(Icons.add),),
                ),
              ],
            ),
          );
        });
  }
}

class forumCard extends StatefulWidget {

  String?userImage;
  String? username;
  String?postTitle;
  String?postDescription;
  String?postImage;


  forumCard(
      {this.postImage,
      this.postDescription,
      this.postTitle,
      this.username,
      this.userImage});

  @override
  State<forumCard> createState() => _forumCardState();
}

class _forumCardState extends State<forumCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 213,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: lightGrey()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(widget.userImage!), ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.username!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const Text(
                                'a month ago',
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      widget.postTitle!,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(widget.postDescription!),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(BASEURL+widget.postImage!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
