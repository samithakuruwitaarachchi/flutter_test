import 'package:ecom/Models/ModelProducts.dart';
import 'package:ecom/Services/ApiService.dart';
import 'package:ecom/views/ProductDetailView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/AppBarLocationText.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  final apiService = ApiService();

  Future<void> locationService() async {
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

  String locationText = "Colombo";
  int _selectedIndex = 0;
  int pageNum = 0;
  List<dynamic>? _products = [];
  late Future<List<Product>> prodList;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData(1);
    locationService();

  }

  Future<List<dynamic>?> fetchData(pageNum) async{

     final res =  await apiService.getProdData(pageNum);
     print("13464 ::: $res");
     return res;
     //return await apiService.getFeatureProdData(pageNum);
    // setState(() {
    //   // _products = res as List;
    //   //print("leaded data ${_products?.length}");
    //   prodList = res;
    //   // print(_products!.length);
    // });

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
            return const CircularProgressIndicator();
          },
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Services',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Messages',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Cart',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _navigateToProductDetailsScreen(BuildContext context, String ProdId) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail(ProductId: ProdId,)));
  }
}
