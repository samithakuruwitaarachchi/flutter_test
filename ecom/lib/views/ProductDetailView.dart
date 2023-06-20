import 'package:ecom/Services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';
class ProductDetail extends StatefulWidget {

  final String ProductId;

  //const ProductDetail({Key? key}) : super(key: key);

  const ProductDetail({required this.ProductId});

  @override
  State<ProductDetail> createState() => _ProductDetailState(this.ProductId);
}

class _ProductDetailState extends State<ProductDetail> {

  final String ProductId;
  _ProductDetailState(this.ProductId);
  final apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProdData(ProductId);

  }

  Future getProdData(prodId) async{

    final res = await apiService.getSingleProdData(prodId);
    print("******* :: $res");
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getProdData(ProductId),
            builder: (context, snapshot){
              if(snapshot.hasData){
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(snapshot.data!['data']['product']['images'][0]['url'],),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 22, 0, 0),
                      child: Text(
                        snapshot.data!['data']['product']['name'],
                        style: TextStyle(
                          color: Color(AppColors.colorBlue),
                          fontWeight: FontWeight.w700,
                          fontSize: 27,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 0, 8),
                      child: Text(
                        snapshot.data!['data']['product']['shortDescription'],
                        style: TextStyle(
                            color: Color(AppColors.colorGray1),
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),


                  ],
                );
              }else{
                print('no data');
              }
              return const CircularProgressIndicator();
            },
          )


        ),







      ),);
  }
}
