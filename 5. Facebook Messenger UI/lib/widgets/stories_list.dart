import 'package:flutter/material.dart';

const imageUrl = "https://scontent.fbeg1-1.fna.fbcdn.net/v/t1.0-9/37262724_665073247174922_6865706832715841536_n.jpg?_nc_cat=103&_nc_ht=scontent.fbeg1-1.fna&oh=c3a2c99bfa7637e7e21a775c642b4f18&oe=5CCAA6EE";

class StoriesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StoriesListState();
  }
}

class _StoriesListState extends State<StoriesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index == 0) {
          return AddToYourStoryButton();
        }
        if (index <= 10) {
          return StoryListItem(
            viewed: false,
          );
        } else {
          return StoryListItem(
            viewed: true,
          );
        }
      },
      itemCount: 21,
    );
  }
}

class StoryListItem extends StatefulWidget {
  
  bool viewed;

  StoryListItem({@required this.viewed});

  @override
  State<StatefulWidget> createState() {
    return _StoryListItemState();
  }
}

class _StoryListItemState extends State<StoryListItem> {

  _buildBorder() {
    if (widget.viewed) {
      return null;
    } else {
      return Border.all(
        color: Colors.blue,
        width: 3
      );
    }
  }

  _getTextStyle() {
    if (widget.viewed) {
      return _viewedStoryListItemTextStyle();
    } else {
      return _notViewedStoryListItemTextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: _buildBorder(),
                image: DecorationImage(
                  image: NetworkImage(imageUrl)
                )
              ),
            ),
            Container(height: 8.0,),
            Text(
              'Abc',
              softWrap: true,
              style: _getTextStyle(),
            ),
          ],
        ),
        Container(width: 12.0,)
      ],
    );
  }
}

class AddToYourStoryButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
                // borderRadius: BorderRadius.circular(5.0)
              ),
              child: Icon(
                Icons.add,
                size: 35.0,
              )
            ),
            Container(height: 8.0,),
            Text(
              'Your story',
              style: _viewedStoryListItemTextStyle()
            ),
          ],
        ),
        Container(width: 12.0,)
      ],
    );
  }
}

_notViewedStoryListItemTextStyle() {
  return TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontWeight: FontWeight.bold
  );  
}

_viewedStoryListItemTextStyle() {
  return TextStyle(
    fontSize: 12,
    color: Colors.grey
  );  
}