
import 'package:ecom/Models/ModelProducts.dart';
import 'package:ecom/Services/ApiService.dart';
import 'package:ecom/views/ProductDetailView.dart';
import 'package:ecom/views/ProfileMain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/AppBarLocationText.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  final apiService = ApiService();


  String locationText = "Fetching your location";
  int _selectedIndex = 0;
  int pageNum = 1;
  List<dynamic>? _products = [];
  late Future<List<Product>> prodList;
  ScrollController _scrollController = ScrollController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(pageNum);
   _handleLocationPermission();
    
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        pageNum++;
        setState(() {});
      }
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    locationService();
    return true;

  }

  Future<void> locationService() async {

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best)
        .timeout(Duration(seconds: 5));

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      setState(() {
        locationText = placemarks[0].subLocality!;
      });


    }catch(err){}

    //
    // Location location = new Location();
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData _locationData;
    //
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    // _locationData = await location.getLocation();
    //
    //

  }


  Future<List<dynamic>?> fetchData(pageNum) async{
     final res =  await apiService.getProdData(pageNum);
     return res;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(
          title:  AppBarLocationText(locationText: locationText),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<List<dynamic>?>(
          future: fetchData(1),
          builder: (context, snapshot){
            print('snapshot has data ddddd');
            if(snapshot.hasData){
              print('snapshot has data ');
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 5,
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                children: List.generate(snapshot.data!.length,
                        (index) {
                      return  GestureDetector(
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            title: Text(snapshot.data![index]['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                          child: Image.network(snapshot.data![index]['images'][0]['url'],
                            fit: BoxFit.cover,),

                        ),
                        onTap: (){
                          _navigateToProductDetailsScreen(context, snapshot.data![index]['code']);
                        },
                      ) ;
                    }),
              );
            }else if (snapshot.hasError) {
              print('snapshot has data Error');
              return Text(snapshot.error.toString());
            }else{
              print('no data');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),


      ),
    );
  }

  void _navigateToProductDetailsScreen(BuildContext context, String ProdId) {
     Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail(ProductId: ProdId,)));
   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileMain()));
  }
}
