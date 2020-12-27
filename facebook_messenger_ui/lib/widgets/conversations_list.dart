import 'package:flutter/material.dart';

const imageUrl = "https://scontent.fbeg1-1.fna.fbcdn.net/v/t1.0-9/37262724_665073247174922_6865706832715841536_n.jpg?_nc_cat=103&_nc_ht=scontent.fbeg1-1.fna&oh=c3a2c99bfa7637e7e21a775c642b4f18&oe=5CCAA6EE";

class ConversationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConversationListState();
  }
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ConversationListItem();
      },
      itemCount: 21,
    );
  }
}

class ConversationListItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConversationListItemState();
  }
}

class _ConversationListItemState extends State<ConversationListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          _buildConversationImage(),
          _buildTitleAndLatestMessage(),      
        ],
      ),
    );
  }

  _buildTitleAndLatestMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildConverastionTitle(),
          Container(height: 2,),
          Row(
            children: <Widget>[
              _buildLatestMessage(),
              Container(width: 4,),
              Center(
                child: Text('.')),
              Container(width: 4,),
              _buildTimeOfLatestMessage()
            ],
          )
        ],
      ),
    );
  }

  _buildConverastionTitle() {
    return Text(
      'John Smith',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold
      ),
    );
  }
  
  _buildLatestMessage() {
    return Text(
      'Hello',
      style: TextStyle(
        color: Colors.grey.shade700
      ),
    );
  }

  _buildTimeOfLatestMessage() {
    return Text(
      '1:21PM',
      style: TextStyle(
        color: Colors.grey.shade700
      )
    );
  }

  _buildConversationImage() {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl)
        )
      ),
    );
  }
}
