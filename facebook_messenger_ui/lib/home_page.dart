
import 'package:facebook_messenger/widgets/app_bar_network_rounded_image.dart';
import 'package:facebook_messenger/widgets/app_bar_title.dart';
import 'package:facebook_messenger/widgets/conversations_list.dart';
import 'package:facebook_messenger/widgets/search_bar.dart';
import 'package:facebook_messenger/widgets/stories_list.dart';
import 'package:flutter/material.dart';

const imageUrl = "https://scontent.fbeg1-1.fna.fbcdn.net/v/t1.0-9/37262724_665073247174922_6865706832715841536_n.jpg?_nc_cat=103&_nc_ht=scontent.fbeg1-1.fna&oh=c3a2c99bfa7637e7e21a775c642b4f18&oe=5CCAA6EE";

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      backgroundColor: Colors.white,
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Container(height: 15, color: Colors.white,),
        MessengerAppBar(
          title: 'Chats',
          actions: <Widget>[
            Icon(Icons.camera_alt),
            Icon(Icons.edit)
          ],
        ),
        _buildRootListView(),
      ],
    );
  }

  _buildRootListView() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildSearchBar();
          } else if (index == 1) {
            return _buildStoriesList();
          } else {
            return ConversationListItem();
          }
        },
        itemCount: 21,
      ),
    );
  }

  _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: SearchBar(),
    );
  }

  _buildStoriesList() {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
      child: StoriesList()
    );
  }
}

class MessengerAppBar extends StatelessWidget {
  
  List<Widget> actions = List<Widget>(0);
  String title;

  MessengerAppBar({this.actions, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(width: 16.0,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppBarNetworkRoundedImage(
                  imageUrl: imageUrl,
                ),
              ),
              Container(width: 8.0,),
              AppBarTitle(
                text: title,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: actions
                .map(
                  (c) => Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: c,
                  )
                )
                .toList(),            
            ),
          )
        ],
      ),
    );
  }
}
