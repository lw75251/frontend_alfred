import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MainPage extends StatelessWidget {

  List<Widget> carousels = [

    CarouselBlock(
      title: "Discover",
      images: [
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250"
      ],
      imageTitles: [
        "Promo",
        "Daily Deals",
        "Refer a Friend",
        "Membership"
      ],
      itemsPerBlock: 1,
      autoPlay: true,
      transformButton: false,
    ),

    CarouselBlock(
      title: "Top Categories",
      images: [
        "http://via.placeholder.com/175x250",
        "http://via.placeholder.com/175x250",
        "http://via.placeholder.com/175x250",
        "http://via.placeholder.com/175x250"
      ],
      imageTitles: [
        "Pizza",
        "Fast Food",
        "American",
        "Chinese"
      ],
      itemsPerBlock: 2,
      autoPlay: false,
      transformButton: true,
    ),

    CarouselBlock(
      title: "Nearby",
      images: [
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250"
      ],
      imageTitles: [
        "Rigos",
        "Rigos",
        "Rigos",
        "Rigos",
      ],
      itemsPerBlock: 1,
      autoPlay: false,
      transformButton: true,
    )

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) => carousels[index],
      separatorBuilder: (BuildContext context, int index) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Divider(
            color: Colors.black,
          ),
        )
      ,
      itemCount: carousels.length, 
    );
        // NearbyBlock(
        //   title: "Nearby",
        //   images: [
        //     "http://via.placeholder.com/325x250",
        //     "http://via.placeholder.com/325x250",
        //     "http://via.placeholder.com/325x250",
        //     "http://via.placeholder.com/325x250"
        //   ],
        //   imageTitles: [
        //     "Rigos",
        //     "Rigos",
        //     "Rigos",
        //     "Rigos",
        //   ],
        // )       
  }
}

class NearbyBlock extends StatelessWidget {
  final String title;
  final List<String> images;
  final List<String> imageTitles;

  const NearbyBlock({
    this.title,
    this.images,
    this.imageTitles,
    Key key
  }) : super(key: key);

    final TextStyle headerStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20.0,
    );

    // Find Light Grey Subtitle
    final TextStyle cardTitleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 20.0,
    );    

    final TextStyle subTitleStyle = const TextStyle(
      color: Colors.black,
      fontSize: 16.0,
    );     


  Widget _buildHeader(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title, style: headerStyle),
          ]
        ),
        subTitle != null ?
          Text(subTitle, 
            style: subTitleStyle
          ) : Container()
      ]) 
    );
  }  

  Widget _buildCard(BuildContext context, String imageUrl, String cardTitle ) { 
     // 1 Per Block
    final _screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: _screenHeight/4,
      child: Row(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(imageUrl, fit: BoxFit.fill),
            Text(cardTitle, style: cardTitleStyle),
        ]),
      ]) 
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (ctx, int) => _buildCard(ctx, images[int], imageTitles[int]),
    );
  }
}

class CarouselBlock extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<String> images;
  final List<String> imageTitles;
  final int itemsPerBlock;
  final int duration;
  final bool autoPlay;
  final bool transformButton;

  CarouselBlock({
    this.title,
    this.subtitle,
    this.images,
    this.imageTitles,
    this.itemsPerBlock = 1,
    this.duration = 1500,
    this.autoPlay = false,
    this.transformButton,
    Key key
  }) : super(key: key);

  @override
  CarouselStateBlock createState() => CarouselStateBlock();
}

class CarouselStateBlock extends State<CarouselBlock> {
  @override
  Widget build(BuildContext context) {
    final double _padding = 10.0;
    final double _screenHeight = MediaQuery.of(context).size.height;

    TextStyle headerStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
    );

    // Find Light Grey Subtitle
    TextStyle cardTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 20.0,
    );    

    TextStyle subTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
    );        

    Widget _buildHeader(String title, String subTitle) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.title, style: headerStyle),
              widget.transformButton ? 
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  color: Colors.black,
                  iconSize: 18,
                  onPressed: (){},
                ) : Container()
            ]
          ),
          subTitle != null ?
            Text(subTitle, 
              style: subTitleStyle
            ) : Container()
        ]) 
      );
    }

    Widget _buildCard(String imageUrl, String cardTitle ) { 
      return widget.itemsPerBlock == 1 ? 
      
      // 1 Per Block
      SizedBox(
        height: _screenHeight/4,
        child: Row(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(imageUrl, fit: BoxFit.fill),
              Text(cardTitle, style: cardTitleStyle),
          ]),
        ]) 
      )

      :

      // 2 Per Block
      SizedBox(
        height: _screenHeight/4,
        child: Row(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(imageUrl, fit: BoxFit.fill),
              Text(cardTitle, style: cardTitleStyle),
          ]),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 5),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(imageUrl, fit: BoxFit.fill),
              Text(cardTitle, style: cardTitleStyle),
          ]) 
        ]) 
      );
    }

    return SizedBox(
      height: _screenHeight/1.8,
      child: Column(
        children: <Widget>[
          _buildHeader(widget.title, widget.subtitle),
          SizedBox(
            height: _screenHeight/2,
            child: Swiper(
              autoplay: widget.autoPlay,
              duration: widget.duration,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.9,
              itemBuilder: (ctx, int) => 
                _buildCard(widget.images[int], widget.imageTitles[int]), 
              itemCount: widget.images.length,
            ),
          )
      ])
    );
  }
}