import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gold_zoid/models/user_model.dart';
import 'package:gold_zoid/repositries/user_login_signup_repositry.dart';
import 'package:http/http.dart' as http;
import 'package:gold_zoid/controllers/custom_exception_handler.dart';
import 'package:provider/provider.dart';

class UserLoginSignUpController extends ChangeNotifier{

  bool _userIsLoggedIn = false;
  //User user = new User();

  UserLoginSignupRepositry reachRepositry = UserLoginSignupRepositry();
  
  registerUser(String emailId,String password,String name) async {
    var msg = '';
    try{
    var response = await reachRepositry.registerUser(emailId,password,name);
    print(response.body);
    var decodedData = _response(response); 
    var responseRepositry = decodedData['Response']; 
    if(responseRepositry == 'Successfully signed up')
    {
      User.fromJson(decodedData);


      _userIsLoggedIn = true;
      msg = responseRepositry; 
    }
    else if( responseRepositry == 'User Already Registered'){
      msg = responseRepositry;
    }
      }
    catch (e){
      msg = '${e.toString()}';
      print(e);
    }
    
    return msg; 
  }
      
   loginUser(String emailId,String password) async {
    var msg = '';
    try{
    var response = await reachRepositry.loginUser(emailId,password);
    print(response.body);
    var decodedData = _response(response); 
    var responseRepositry = decodedData['Response']; 
    if(responseRepositry == 'Successfully Logged In')
    {
      User.fromJson(decodedData);       // parsing user data ... .... .
      _userIsLoggedIn = true;
      msg = responseRepositry; 
    }
    else if( responseRepositry == 'Invalid Email or Password'){
      msg = responseRepositry;
    }
      }
    catch (e){
      msg = '${e.toString()}';
      print(e);
    }
    
    return msg; 
  }   
      
      dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
      var responseJson = json.decode(response.body);
        throw BadRequestException(responseJson['Response'].toString());
      case 401:
      case 403:
      var responseJson = json.decode(response.body);
        throw UnauthorisedException(responseJson['Response'].toString());
      case 500:
      default:
        throw FetchDataException('No Internet Connection');
    }
  }
}