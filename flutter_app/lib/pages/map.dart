import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MapStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapPage();
  }
}


class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 15.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              //
            }),
        title: Text("SOCRATICA"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(19.022480, 72.855026), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(19.022480, 72.855026), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://letslearn.institute/wp-content/uploads/2019/12/WhatsApp-Image-2019-02-14-at-11.12.10-2-1024x682.jpeg",
                  19.0224,
                  72.855026,
                  "manisha Classes"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://images.jdmagicbox.com/comp/nagpur/a8/0712px712.x712.171220214340.s1a8/catalogue/perfect-tuition-classes-ramna-maroti-nagar-nagpur-tutorials-8vllqsoi4u.jpg",
                  19.02512,
                  72.856209,
                  "Praveen's Classes"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://static.toiimg.com/photo/msid-67955304/67955304.jpg?resizemode=4&width=400 ",
                  19.0324,
                  72.855026,
                  "FIT-JEE"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://3.imimg.com/data3/NA/HH/MY-9252310/collage-coaching-classes-250x250.png",
                  19.02812,
                  72.856209,
                  "Avnessh Tutorial"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://image.shutterstock.com/image-photo/different-ages-kids-expressing-interest-260nw-687310027.jpg",
                  19.04812,
                  72.87,
                  "Kodamo Karate Classes"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://programmatixinstitute.com/wp-content/uploads/programmatix-institute-logo.png",
                  19.050,
                  72.855026,
                  "Programmatix"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTSemre5joL1w2gFH7jDhBb-7-qf-osWHXq9kbEO6g-B9u1kP3C&usqp=CAU",
                  19.028,
                  72.859,
                  "Vimal Classes"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://2.bp.blogspot.com/-88tsaW-aWfc/T5J8A5_y9EI/AAAAAAAABa0/MhzyS7MVNpQ/s1600/Students,+Eastern+Fare+Music+Foundation+small+gtr.jpg",
                  19.026965,
                  72.857118,
                  "Thadomal Guitar Classes"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://imgmedia.lbb.in/media/2019/03/5c8b54878f6a700ac712b29c_1552635015274.jpg",
                  19.044,
                  72.858,
                  "Ramesh Swimming classes"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQoZxydicQ7rxlEFtBBFrSTZ0UBu0ZkiHmEDblxCtdShlniy4em&usqp=CAU",
                  19.029,
                  72.90,
                  "Crehan's UPSC classes"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: myDetailsContainer1(restaurantName),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName,
                style: TextStyle(
                    color: Color(0xff6200ee),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "4.1",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                  child: Icon(
                    FontAwesomeIcons.solidStarHalf,
                    color: Colors.amber,
                    size: 15.0,
                  ),
                ),
                Container(
                    child: Text(
                      "(946)",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
              ],
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition:
        CameraPosition(target: LatLng(19.022480, 72.855026), zoom: 15),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          newyork1Marker,
          newyork2Marker,
          newyork3Marker,
          newyork4Marker,
          newyork5Marker,
          newyork6Marker,
          newyork7Marker,
          gramercyMarker,
          bernardinMarker,
          blueMarker,
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker gramercyMarker = Marker(
  markerId: MarkerId('Manisha Classes'),
  position: LatLng(19.0224, 72.855026),
  infoWindow: InfoWindow(title: 'Manisha Classes'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker bernardinMarker = Marker(
  markerId: MarkerId("Praveen's classes"),
  position: LatLng(19.02512, 72.856209),
  infoWindow: InfoWindow(title: "Praveen's classes"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker blueMarker = Marker(
  markerId: MarkerId('FIT-JEE'),
  position: LatLng(19.0324, 72.855026),
  infoWindow: InfoWindow(title: 'FIT-JEE'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork1Marker = Marker(
  markerId: MarkerId('Avnessh Tutorial'),
  position: LatLng(19.02812, 72.856209),
  infoWindow: InfoWindow(title: 'Avnessh Tutorial'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork2Marker = Marker(
  markerId: MarkerId('Kodamo Karate Classes'),
  position: LatLng(19.04812, 72.87),
  infoWindow: InfoWindow(title: 'Kodamo Karate Classes'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork3Marker = Marker(
  markerId: MarkerId('Programmatix'),
  position: LatLng(19.050, 72.855026),
  infoWindow: InfoWindow(title: 'Programmatix'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork4Marker = Marker(
  markerId: MarkerId('Vimal classes'),
  position: LatLng(19.028, 72.859),
  infoWindow: InfoWindow(title: 'Vimal classes'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork5Marker = Marker(
  markerId: MarkerId('Thadomal Guitar class'),
  position: LatLng(19.026965, 72.857118),
  infoWindow: InfoWindow(title: 'Thadomal Guitar class'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork6Marker = Marker(
  markerId: MarkerId('Ramesh Swimming classes'),
  position: LatLng(19.044, 72.858),
  infoWindow: InfoWindow(title: 'Ramesh Swimming classes'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);
Marker newyork7Marker = Marker(
  markerId: MarkerId("Crehan's UPSC Classes"),
  position: LatLng(19.029, 72.90),
  infoWindow: InfoWindow(title: "Crehan's UPSC Classes"),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueViolet,
  ),
);