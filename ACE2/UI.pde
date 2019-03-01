/*  UI-related functions */
int CONNECT_LIST = 0; 
int DISCONNECT_LIST = 1;
int listState = CONNECT_LIST;

void mousePressed() {
  //Disconnect Button
  if (mouseX >= 0 && mouseX <= btnWidth && mouseY >= 0 && mouseY <= btnHeight) {
    disconnectBlueT();
    isPage2=true;
    isPage3=false;
    isPage4=false;
    SENSOR_NUMBER = 0;
    println("Click Button 1");
  }
  //Connect Button
  else if (mouseX >= btnWidth && mouseX <= btnWidth*2 && mouseY >= 0 && mouseY <= btnHeight) {
    selectBlueT();
    isPage1=false;
    isPage2=true;
    isPage3=false;
    isPage4=false;
    SENSOR_NUMBER = 0;
    println("Click Button 2");
  }
  // Report Button
  else if (mouseX >= btnWidth*2 && mouseX <= btnWidth*3 && mouseY >= 0 && mouseY <= btnHeight) {
    background(0, 0, 0);
    isPage1=false;
    isPage2=false;
    isPage3=true;
    isPage4=false;
    SENSOR_NUMBER = 0;
    println("Click Button 3");
  }
  // Graphic Button
  else if (mouseX >= btnWidth*3 && mouseX <= (btnWidth*3)+ btnWidth && mouseY >= 0 && mouseY <= btnHeight) {
    background(0, 0, 0);
    isPage1=false;
    isPage2=false;
    isPage3=false;
    isPage4=true;
    SENSOR_NUMBER = 0;
    println("Click Button 4");
  }
  /** BUTTON GRAPHIC MQ135 = 1 **/
  if (isPage4 && (mouseX >= 0 && mouseX <= btnWidth && mouseY >= btnHeight && mouseY <= 2*btnHeight) ) {
    background(0, 0, 0);
    isPage1=false;
    isPage2=false;
    isPage3=false;
    isPage4=true;
    SENSOR_NUMBER = 1;
    /* https://abcienciade.wordpress.com/2008/07/20/concentracion-de-dioxido-de-carbono-en-ppm/ */
    setupGraphicMQ135(410, 460);

    println("Click Button MQ135");
  }
  /** BUTTON GRAPHIC MQ7 = 2 **/
  else if (isPage4 && (mouseX >= btnWidth && mouseX <= btnWidth*2 && mouseY >= btnHeight && mouseY <= 2*btnHeight) ) {
    background(0, 0, 0);
    isPage1=false;
    isPage2=false;
    isPage3=false;
    isPage4=true;
    SENSOR_NUMBER = 2;
    /** https://www.wcf.com/hoja-de-informaci%C3%B3n-sobre-el-mon%C3%B3xido-de-carbono-co **/
    setupGraphicMQ7(50, 200);
    println("Click Button MQ7");
  }
  /** BUTTON GRAPHIC GUVA = 3 **/
  else if (mouseX >= btnWidth*2 && mouseX <= btnWidth*3 && mouseY >= btnHeight && mouseY <= 2*btnHeight) {
    background(0, 0, 0);
    isPage1=false;
    isPage2=false;
    isPage3=false;
    isPage4=true;
    SENSOR_NUMBER = 3;
    //setupGraphicGUVA(380, 415);
    println("Click Button GUVA");
  }
}

void selectBlueT() {  
  listState = CONNECT_LIST;  
  if (bt.getDiscoveredDeviceNames().size() > 0) {
    ArrayList<String> list = bt.getDiscoveredDeviceNames();
    list.add("CANCEL");
    klist = new KetaiList(this, list);
  } else if (bt.getPairedDeviceNames().size() > 0) {
    ArrayList<String> list = bt.getPairedDeviceNames();
    list.add("CANCEL");
    klist = new KetaiList(this, list);
  }
}

void disconnectBlueT() {
  listState = DISCONNECT_LIST;
  if (bt.getConnectedDeviceNames().size() > 0) {
    ArrayList<String> list = bt.getConnectedDeviceNames();
    list.add("CANCEL");
    klist = new KetaiList(this, list);
  }
}

void drawUI() {
  //Draw top shelf UI buttons
  pushStyle();
  fill(0);
  stroke(255);
  // rect shape white
  /*rect( posX, posY, width, Height )*/
  rect( 0, 0, btnWidth, btnHeight);
  rect( btnWidth, 0, btnWidth, btnHeight);
  rect( btnWidth*2, 0, btnWidth, btnHeight);
  rect( btnWidth*3, 0, btnWidth, btnHeight);

  if (isPage2) {
    noStroke();
    //blue rect shape background     
    fill(50, 150, 200);
    rect(width/4, 0, width/4, 50*displayDensity);
    info = getBluetoothInformation();
    text( info, 5, 90*displayDensity);
    drawMenu();
  } else if (isPage3) {
    noStroke();
    //blue rect shape background
    fill(50, 150, 200);   
    rect((width/4)*2, 0, width/4, 50*displayDensity);
    drawMenu();
    textSize( 32 );
    text("Reporte.", width/4, 120); 

    textSize( 24 );
    text( "Date: " + getDateAndTime(1) +"\n" +
      "Time: " + getDateAndTime(2) +"\n" +
      "------------------------------------------------------------\n" +
      LABEL_STATE, 5, 160);
  } else if (isPage4) {
    noStroke();
    //blue rect shape background
    fill(50, 150, 200);
    rect(btnWidth*3, 0, btnWidth, btnHeight);
    //fill(90, 150, 175);
    fill(125);
    rect( 0, btnHeight, btnWidth, btnHeight);
    rect( btnWidth, btnHeight, btnWidth, btnHeight);
    rect( btnWidth*2, btnHeight, btnWidth, btnHeight);
    if (SENSOR_NUMBER == 1) {
      //blue rect shape background     
      fill(50, 180, 230);
      rect( 0, btnHeight, btnWidth, btnHeight);
    }
    else if (SENSOR_NUMBER == 2) {
      //blue rect shape background     
      fill(50, 180, 230);
      rect( btnWidth, btnHeight, btnWidth, btnHeight);
    }
    else if (SENSOR_NUMBER == 3) {
      //blue rect shape background     
      fill(50, 180, 230);
      rect( btnWidth*2, btnHeight, btnWidth, btnHeight);
    }
    drawMenu();
  }

  if (!isPage2) {  
    noStroke();
    fill(50, 150, 200);
  } else {
    fill(0);
    stroke(255);
  }
  popStyle();
}
void drawMenu() {
  fill(255);
  text("Disconnect.", 5, 30*displayDensity); 
  text("Connect", width/4+5, 30*displayDensity); 
  text("Reports", width/4*2+5, 30*displayDensity);
  text("Graphics", width/4*3+5, 30*displayDensity);
  if (isPage4) {
    text("Sensor\nMQ135.", 5, 20*displayDensity + btnHeight); 
    text("Sensor\nMQ7.", btnWidth+5, 20*displayDensity + btnHeight); 
    text("Sensor\nGUVA.", btnWidth*2+5, 20*displayDensity + btnHeight);
  }
}

void onKetaiListSelection(KetaiList klist) {
  String selection = klist.getSelection();

  if (listState == CONNECT_LIST) {
    if (!selection.equals("CANCEL")) {
      bt.connectToDeviceByName(selection);
    }
  } else if (listState == DISCONNECT_LIST) {    
    if (!selection.equals("CANCEL")) {
      bt.disconnectDevice(selection);
    }
  }
  //dispose of list for now
  klist = null;
}
