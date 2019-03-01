/** IMPORT TO CONNECT AT SERVER **/
import http.requests.*;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import java.io.File;
//***Mario******
import java.util.*;
//**************
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

/** It is for BT enabling on startup **/
import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import ketai.sensors.*; 

/** It's necesary for doing all the graphics **/
import grafica.*;

int F_X = 0;
int EJE_X = 0;

/** VARS TO DRAW THE GRAPHIC MQ135 **/
public GPlot plotMQ135;


/** VARS TO DRAW THE GRAPHIC MQ7 **/
public GPlot plotMQ7;

/** VARS TO DRAW THE GRAPHIC MQ7 **/
public GPlot plotGUVA;

/** VARS TO CONNECT ON THE SERVER **/
String URL;
DefaultHttpClient httpClient;
HttpPost httpPost;
HttpResponse response;
HttpEntity entity;
List nameValuePairs;

/** VARS TO GET LOCATION **/
double POSS_LONGITUDE;
double POSS_LATITUDE;
double POSS_ALTITUDE;
KetaiLocation LOCATION;
String LABEL_STATE_GEOLOCATION;

/** VARS TO CONNECT BLUETOOTH **/
KetaiBluetooth bt;
String info = "";
KetaiList klist;
PVector remoteMouse = new PVector();

ArrayList<String> devicesDiscovered = new ArrayList();

float btnWidth;
float btnHeight;

boolean isPage1;
boolean isPage2;
boolean isPage3;
boolean isPage4;
String MESSAGE_IN; /* this save all read bit fron bluetooth */
String MESSAGE_REP; /* this conteined the string of values get from arduino */

/** TO SHOW THE INFO ON THE SCREEN **/
String LABEL_STATE;
PFont f;

/** VARS TO ALL SENSORS **/
String MQ135;
String MQ7;
String GUVA;
int SENSOR_NUMBER;

/** VARS TO GET DATE **/
int YEAR;
int MONTH;
int DAY;
String DATE;
int HOUR;
int MINUTE;
int SECOND;
String TIME;

/** VARS TO DATA RECEIVE **/
static final char STX='|';
static final char ETX=';';
static final char EOT='\4';



//************Marrio**********************
int calculado=100;
String numero="";
float r=0.0;
int y1=0;
int y2=0;
int x1=100;
int x2=100;
PImage fondo,termo;
float x = 30;
float y = 700;
LinkedList<tupla> list;
//****************************************

//********************************************************************
// The following code is required to enable bluetooth at startup.
//********************************************************************
void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  bt = new KetaiBluetooth(this);
  println("Creating KetaiBluetooth");
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
  bt.onActivityResult(requestCode, resultCode, data);
}

//********************************************************************

void setup() { 
  //*********Mario************
    list=new LinkedList<tupla>();
    tupla tp= new tupla();   
    tp.y1=0;
    tp.y2=0;
    tp.x1=100;
    tp.x2=100;
    list.add(tp);
  //**************************
  fullScreen();
  orientation(PORTRAIT);
  btnWidth = (width/4);
  btnHeight = 50*displayDensity;

  background(0, 0, 0);
  stroke(255);
  textSize(16*displayDensity);

  //start listening for BT connections
  bt.start();

  isPage1 = false;
  isPage2 = true;
  isPage3 = false;
  isPage4 = false;

  MESSAGE_IN =  "Report.";
  MESSAGE_REP = "";
  LABEL_STATE = "";

  /** VARS TO SENSOR ALL THE SENSORS**/
  MQ135 = "";
  MQ7 = "";
  GUVA = "";
  /* GET GEOLOCATION*/
  POSS_LONGITUDE = 0;
  POSS_LATITUDE = 0;
  POSS_ALTITUDE = 0;
  LOCATION = new KetaiLocation(this);
  LABEL_STATE_GEOLOCATION = "";
  getGeolocation();

  /** VART TO SET DATE AND HOUR **/
  YEAR = 0;
  MONTH = 0;
  DAY = 0;
  HOUR = 0;
  MINUTE = 0;
  SECOND = 0;
  String DATE = "";
  String TIME = "";

  /** VARS TO CONNECT ON THE SERVER AND I SEND ONE DATA TO TEST THE CONNECTION **/
  URL = "https://apex.oracle.com/pls/apex/ace2g3/sensores/ambiente/";

  try {
    httpClient = new DefaultHttpClient();
    httpPost = new HttpPost( URL );
    /** VALUE TO TEST THE SERVER **/
    nameValuePairs = new ArrayList(2);
    nameValuePairs.add( new BasicNameValuePair("latitud", "0"));
    nameValuePairs.add( new BasicNameValuePair("longitud", "0"));
    nameValuePairs.add( new BasicNameValuePair("mq7", "0"));
    nameValuePairs.add( new BasicNameValuePair("mq135", "0"));
    nameValuePairs.add( new BasicNameValuePair("guvas12sduv", "0"));

    httpPost.setEntity( new UrlEncodedFormEntity( nameValuePairs ) );
    nameValuePairs.clear();
    println( "executing request: " + httpPost.getRequestLine() );
    response = httpClient.execute( httpPost );
    entity = response.getEntity();

    /** print status server **/
    println("----------------------------------------");
    println( response.getStatusLine() );
    println("----------------------------------------");

    if ( entity != null ) { 
      println( "ENTITY NULL" );
      //entity.writeTo( System.out );
      //entity.consumeContent();
    }
    /** SHUTDOWN THE SERVER  **/
    //httpClient.getConnectionManager().shutdown();
  } 
  catch( Exception e ) { 
    e.printStackTrace();
  }

  f = createFont("Arial", 20, true);
  /** INITIALIZE VARIABLE FIRST GRAPHIC **/
  plotMQ135 = new GPlot(this);
  plotMQ7 = new GPlot(this);
  plotGUVA = new GPlot(this);
  SENSOR_NUMBER = 0;
  //println("Density: " + displayDensity);
}

void draw() {
  if (isPage1) {
    background(0, 0, 0);
  } else if (isPage2) {
    background(0, 0, 0);
    //info = getBluetoothInformation();
    //text( info, 5, 90*displayDensity);
  } else if (isPage3) {
    background(0, 0, 0);
  } else if (isPage4) {    
    background(0, 0, 0);
    if (SENSOR_NUMBER == 1 ){
      doGraphicMQ135();
    }
    else if (SENSOR_NUMBER == 2 ){
      doGraphicMQ7();
    }
    else if (SENSOR_NUMBER == 3 ){
      //doGraphicGUVA();
      
      
      //************Mario*************
        PintarGraficaUV();
      //******************************
    
  }
    
  }
  drawUI();
  getGeolocation();
}
String getDateAndTime(int val) {
  if ( val == 1) {
    YEAR = year();
    MONTH = month();
    DAY = day();
    DATE = DAY + "/" + MONTH + "/" + YEAR;
    return DATE;
  } else if ( val == 2) {
    HOUR = hour();
    MINUTE = minute();
    SECOND = second();
    TIME = HOUR + ":" + MINUTE + ":" + SECOND;
    return TIME;
  }
  return "";
}
void getGeolocation() {
  if (LOCATION == null || LOCATION.getProvider() == "none") {
    LABEL_STATE_GEOLOCATION = "Location data is unavailable. \n" +
      "Please check your location settings.";
  } else {
    LABEL_STATE_GEOLOCATION = "Location data:\n" + 
      "----------------------\n" + 
      "Latitude: " + POSS_LATITUDE + "\n" + 
      "Longitude: " + POSS_LONGITUDE + "\n" + 
      "Altitude: " + POSS_ALTITUDE
      //"Accuracy: " + accuracy + "\n" +
      //"Provider: " + location.getProvider()
      ;
  }
}

void onLocationEvent(Location _location) {
  println("onLocation event: " + _location.toString());
  POSS_LONGITUDE = _location.getLongitude();
  POSS_LATITUDE = _location.getLatitude();
  POSS_ALTITUDE = _location.getAltitude();
  //accuracy = _location.getAccuracy();
}
// method for managing data received
void onBluetoothDataEvent(String name, byte[] data) {
  if (isPage2) {
    return;
  }  
  MESSAGE_IN += new String(data);
  if ( data[data.length-1] == EOT) {
    validateMessageIN( MESSAGE_IN );
  }
}

String validateMessageIN(String text ) {
  MESSAGE_REP = "";
  if ( text.length() == 0 ) {
    return MESSAGE_REP;
  }
  if ( text.length() > 0 ) {
    int startIndex = 0;
    int endIndex = 0;
    while ( text.charAt(startIndex) != STX ) {
      startIndex = startIndex + 1;
    }
    endIndex = startIndex;
    while ( text.charAt(endIndex) != EOT ) {
      endIndex = endIndex + 1;
    }
    if (startIndex < endIndex ) {
      MESSAGE_REP = text.substring(startIndex, endIndex );
      //println("-----------------");
      //println(MESSAGE_REP);
      getValueFromMessageIn(MESSAGE_REP);
    }  
    MESSAGE_IN = "";   
    return MESSAGE_REP;
  }
  return MESSAGE_REP;
}


void getValueFromMessageIn(String values ) {
  String tmp = values.substring(1, values.length()-1);
  String[] valuesSensor = tmp.split(";");
  MQ135 = valuesSensor[0];
  MQ7 = valuesSensor[1];
  GUVA = valuesSensor[2];
  println("-----------------");
  println("Sensor MQ135: " + MQ135);
  println("Sensor MQ7: " + MQ7);
  println("Sensor GUVA: " + GUVA);
  //**********Mario****************
  LlenarGrafica(GUVA);
  //*******************************
  LABEL_STATE  = "Sensor (MQ135)\nCalidad del aire: " + MQ135 + " ppm.\n\n";
  LABEL_STATE += "------------------------------------------\n";
  LABEL_STATE += "Sensor (MQ7)\nMonoxido de Carbono: " + MQ7 + " ppm.\n\n";
  LABEL_STATE += "------------------------------------------\n";
  LABEL_STATE += "Sensor (GUVA)\nRadiacion solar: " + GUVA + " kW/m^2.\n\n";
  LABEL_STATE += "------------------------------------------\n";
  LABEL_STATE += LABEL_STATE_GEOLOCATION;
  /** If I have received any data from bluetooth, I send it at the server too **/
  sendDataServer(); /*DESHABILITAR*/
}
String getBluetoothInformation() {
  String btInfo = "Status connection: ";
  btInfo += bt.isStarted() + "\n";
  //btInfo += "Discovering: " + bt.isDiscovering() + "\n";
  //btInfo += "Device Discoverable: "+bt.isDiscoverable() + "\n";
  btInfo += "\nName connected device: \n";

  ArrayList<String> devices = bt.getConnectedDeviceNames();
  for (String device : devices) {
    btInfo+= device+"\n";
  }
  if (bt.getConnectedDeviceNames().size() == 0) {
    btInfo += "There aren't connected devices.";
  }
  return btInfo;
}


void sendDataServer() {
  try {    
    if ( !nameValuePairs.isEmpty() ) {
      nameValuePairs.clear();
    }
    nameValuePairs.add( new BasicNameValuePair("latitud", Double.toString( POSS_LATITUDE )) );
    nameValuePairs.add( new BasicNameValuePair("longitud", Double.toString( POSS_LONGITUDE )) );
    nameValuePairs.add( new BasicNameValuePair("mq7", MQ7 ) );
    nameValuePairs.add( new BasicNameValuePair("mq135", MQ135 ) );
    nameValuePairs.add( new BasicNameValuePair("guvas12sduv", GUVA ) );

    httpPost.setEntity( new UrlEncodedFormEntity( nameValuePairs ) );

    println( "executing request: " + httpPost.getRequestLine() ) ;
    HttpResponse response = httpClient.execute( httpPost );
    HttpEntity   entity   = response.getEntity();

    /** print status server **/
    println("----------------------------------------");
    println( response.getStatusLine() );
    println("----------------------------------------");

    if ( entity != null ) { 
      println( "ENTITY NULL" );
      //entity.writeTo( System.out );
      //entity.consumeContent();
    }
    /** SHUTDOWN THE SERVER  **/
    //httpClient.getConnectionManager().shutdown();
  } 
  catch( Exception e ) { 
    e.printStackTrace();
  }
}
void setupGraphicMQ135(int limit1, int limit2){
  /** RESET THE GRAPHIC **/
  plotMQ135.setPoints(new GPointsArray());
  /** GREEN LINE **/
  int nPoints2 = 60;
  GPointsArray points2 = new GPointsArray(nPoints2);

  for (int i = 0; i < 60; i++) {    
    points2.add(i, limit1);
  }

  //plotMQ135.activatePanning();
  plotMQ135.addLayer("surface", points2);
  //Change the second layer line color
  //plotMQ135.getLayer("surface").setLineColor(color(100, 255, 100));
  plotMQ135.getLayer("surface").setPointColor(color(100, 255, 100));
  /** RED LINE **/
  int nPoints3 = 60;
  GPointsArray points3 = new GPointsArray(nPoints3);

  for (int i = 0; i < 60; i++) {
    points3.add(i, limit2);
  }

  //plotMQ135.activatePanning();
  plotMQ135.addLayer("surface1", points3);
  plotMQ135.getLayer("surface1").setPointColor(color(150, 20, 20));
  
}
void doGraphicMQ135() {  
  background(255);
  EJE_X = second();
  F_X = getValMQInt(MQ135);
    
  if (F_X > 0){
    plotMQ135.setPointColor(color(50, 100, 150));
  }
  else{
    plotMQ135.setPointColor(color(240, 240, 240));
  }
  
  plotMQ135.addPoint(EJE_X, F_X);
  /** RESET THE GRAPHIC **/
  if ( EJE_X > 58 ) {
    plotMQ135.setPoints(new GPointsArray());
  }
  // Draw the second plotMQ135  
  plotMQ135.beginDraw();
  plotMQ135.drawBackground();
  plotMQ135.setPos(0, 150);
  plotMQ135.setDim(400, 500);
  plotMQ135.setTitleText( "Calidad del aire." );
  plotMQ135.getYAxis().setAxisLabelText("f(X) = Concentracion ppm.");
  plotMQ135.getXAxis().setAxisLabelText("(X) = Hora: "+hour() +":" + minute() + ":" + second());
  plotMQ135.drawBox();
  plotMQ135.drawXAxis();
  plotMQ135.drawYAxis();
  plotMQ135.drawTitle();
  //plotMQ135.drawGridLines(GPlot.BOTH);
  plotMQ135.drawLines();
  plotMQ135.drawPoints();
  plotMQ135.endDraw();
  
  
  /* LABEL LIMIT 1 */
  fill(10, 255, 100);
  rect(25, 745, 25, 25);
  fill(0);
  text( "Limite recomendado. ", 55, 765);
  /* LABEL LIMIT 2 */
  fill(150, 20, 20);
  rect(25, 780, 25, 25);
  fill(0);
  text( "Nivel peligroso. ", 55, 805);
  
  text( "Sensor (" + "MQ135" + ")\n" + "Calidad del aire." + ": " + F_X + " ppm.\n\n",25,840 );
  
}

void setupGraphicMQ7(int limit1, int limit2){
  /** RESET THE GRAPHIC **/
  plotMQ7.setPoints(new GPointsArray());
  /** GREEN LINE **/
  int nPoints2 = 60;
  GPointsArray points2 = new GPointsArray(nPoints2);

  for (int i = 0; i < 60; i++) {    
    points2.add(i, limit1);
  }

  //plotMQ7.activatePanning();
  plotMQ7.addLayer("surface", points2);
  //Change the second layer line color
  //plotMQ7.getLayer("surface").setLineColor(color(100, 255, 100));
  plotMQ7.getLayer("surface").setPointColor(color(100, 255, 100));
  /** RED LINE **/
  int nPoints3 = 60;
  GPointsArray points3 = new GPointsArray(nPoints3);

  for (int i = 0; i < 60; i++) {
    points3.add(i, limit2);
  }

  //plotMQ7.activatePanning();
  plotMQ7.addLayer("surface1", points3);
  plotMQ7.getLayer("surface1").setPointColor(color(150, 20, 20));
  
}
void doGraphicMQ7() {  
  background(255);
  
  EJE_X = second();
  F_X = getValMQInt(MQ7);
    
  if (F_X > 0){
    plotMQ7.setPointColor(color(50, 100, 150));
  }
  else{
    plotMQ7.setPointColor(color(240, 240, 240));
  }
  
  plotMQ7.addPoint(EJE_X, F_X);
  /** RESET THE GRAPHIC **/
  if ( EJE_X > 58 ) {
    plotMQ7.setPoints(new GPointsArray());
  }
  // Draw the second plotMQ7  
  plotMQ7.beginDraw();
  plotMQ7.drawBackground();
  plotMQ7.setPos(0, 150);
  plotMQ7.setDim(400, 500);
  plotMQ7.setTitleText( "Monoxido de Carbono .");
  plotMQ7.getYAxis().setAxisLabelText("f(X) = Concentracion ppm.");
  plotMQ7.getXAxis().setAxisLabelText("(X) = Hora: "+hour() +":" + minute() + ":" + second());
  plotMQ7.drawBox();
  plotMQ7.drawXAxis();
  plotMQ7.drawYAxis();
  plotMQ7.drawTitle();
  //plotMQ7.drawGridLines(GPlot.BOTH);
  plotMQ7.drawLines();
  plotMQ7.drawPoints();
  plotMQ7.endDraw();
  
  
  /* LABEL LIMIT 1 */
  fill(10, 255, 100);
  rect(25, 745, 25, 25);
  fill(0);
  text( "Limite recomendado. ", 55, 765);
  /* LABEL LIMIT 2 */
  fill(150, 20, 20);
  rect(25, 780, 25, 25);
  fill(0);
  text( "Nivel peligroso. ", 55, 805);
  
  text( "Sensor (" + "MQ7" + ")\n" + "Monoxido de Carbono ." + ": " + F_X + " ppm.\n\n",25,840 );
  
}

int getValMQInt(String val) {
  try {    
    return Integer.parseInt(val);
  }
  catch(NumberFormatException e) {
    return 0;
  }
}





//***********Mario****************
void PintarGraficaUV(){
   background(0, 0, 127);
      stroke(255, 0, 0);
      ellipse(100,1000,50,50);
      
      
        if(list.size()>0){
            stroke(255, 0, 0);
            rect(75,1000-(list.get(list.size()-1).y2*60/10),50,(list.get(list.size()-1).y2*60/10));
         }
         
      fill(0,255,0);
      fondo=loadImage("clima.png");
      image(fondo,50,150,200,200);
      termo=loadImage("cronometro.png");
      image(termo,300,100,400,400);  
      strokeWeight(2);
      stroke(12,237,233);
      line(100,400,100,1000);
      line(100,1000,600,1000);
      
      for(int i=0;i<10;i++){
        line(75,(i*60)+400,125,(i*60)+400);
        calculado=100-(i*10);       
        text(String.valueOf(calculado),60,(i*60)+400);
        line(150+(i*50),975,150+(i*50),1025);
        //textSize(24);
        calculado=10+(10*i);
        text(String.valueOf(calculado),130+(i*50),1075);
       }
    
      fill(0,255,0);
      text(GUVA,400,600);


      //*****texto Vertical******
      fill(255,0,0);
      textAlign(CENTER,BOTTOM);
      pushMatrix();
      translate(x,y);
      rotate(-HALF_PI);
      text("f(x)=Radiacion Solar",0,0);
      popMatrix();
      //**************************
      
      text("X=Tiempo",350,1150);
      
      if(list.size()>=12){
        list.clear();
          y1=0;
          y2=0;
          x1=100;
          x2=100;
      }
      stroke(34, 228, 240);
      for(int i=0;i<list.size();i++){
          line(list.get(i).x1,1000-(list.get(i).y1*60/10),list.get(i).x2,1000-(list.get(i).y2*60/10));
      }  
}



void LlenarGrafica(String datoUV){

     y1=y2;
     
     if(datoUV.contains(".")){
       y2=(int)Double.parseDouble(datoUV);
     }else{
       y2=Integer.parseInt(datoUV);
     }
     //y2=(int)Math.round(Float.parseFloat(datoUV));
     x1=x2;
     x2+=50;
     tupla tp= new tupla();
     tp.x1=x1;
     tp.x2=x2;
     tp.y1=y1;
     tp.y2=y2;
     list.add(tp);
  
}

public class tupla{
  int y1;
  int y2;
  int x1;
  int x2;
}
//********************************
