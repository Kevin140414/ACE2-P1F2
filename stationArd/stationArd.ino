/** VARS TO MQ135 SENSOR **/
int MQ135 = 0;
int beep = 8;
int led1 = 9;
int led2 = 10;
int led3 = 11;
int led4 = 12;
int airN = 415;

/** VARS TO MQ7 SENSOR **/
int MQ7 = 0;

/** VARS TO GUVA SENSOR **/
int GUVA = 0;

int seg = 1000;
int contador = 0;
const char ETX = ';'; /* End of Text */
const char STX = '|'; /* Start of Text */
const char EOT = '\x004'; /* End of Transmission */

void setup() {
  Serial.begin(9600);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(led3, OUTPUT);
  pinMode(led4, OUTPUT);

  digitalWrite(led1, LOW);
  digitalWrite(led2, LOW);
  digitalWrite(led3, LOW);
  digitalWrite(led4, LOW);

}

void loop() {
  if (contador < 15 ) {
    sensorMQ135();
    sensorMQ7();
    sensorGUVA();
    sendData();
    contador = contador + 1;
  }
  else {
    delay(2 * seg);// ORIGINAL VALUE = 3
    contador = 0;
  }
}

void sensorMQ135() {
  /* Read MQ-135 sensor */
  //MQ135 = analogRead(A0);
  int valIni = 55;
  int muestra[10];
  int valProm = 0;
  int refer = 0;
  MQ135 = 0;
  int promed = 0;

  for (int x = 0; x < 10; x++) {
    muestra[x ] = analogRead(A0);
  }

  for (int x = 0; x < 10; x++) {
    promed = promed + muestra[x];
  }
  
  valProm = promed / 10;
  refer = valProm - valIni;
  MQ135 = map(refer, 0, 1023, 400, 5000);

//  Serial.print("Dioxido de Carbono: ");
//  Serial.print(MQ135);
//  Serial.println(" PPM");
  
  digitalWrite(led1, HIGH);
  delay(5);
  digitalWrite(led1, LOW);  
}

void sensorMQ7() {
  /* Read MQ-7 sensor */
  //MQ7 = analogRead(A1);
  int valIni = 55;
  int muestra[10]; 
  int valProm = 0; 
  int refer = 0;
  MQ7 = 0; 
  int promed = 0;

  for (int x = 0; x < 10; x++) {
    muestra[x] = analogRead(A1);
  }

  for (int x = 0; x < 10; x++) {
    promed = promed + muestra[x];
  }  
  valProm = promed / 10;
  refer = valProm - valIni;
  MQ7 = map(refer, 0, 1023, 50, 500);
//  Serial.print("Monoxido de Carbono: ");
//  Serial.print(MQ7);
//  Serial.println(" PPM");
  
  digitalWrite(led2, HIGH);
  delay(5);
  digitalWrite(led2, LOW);

}
void sensorGUVA(){
  /* Read GUVA sensor  */
  //GUVA = analogRead(A2);
  /** CODE FROM DATASHEET **/
  //float gotVoltage;
  int  sensorValue;
  GUVA = 0;
  sensorValue = analogRead(A2);
  //gotVoltage = sensorValue / 1024 * 5;
//  Serial.print("|sensor Value = ");
//  Serial.print(sensorValue);
//  Serial.println(" VAnalogiv");

  if (sensorValue < 10 ){
    GUVA = 0;
  }
  else if (sensorValue < 41 ){
    GUVA = 1;
  }
  else if (sensorValue < 65 ){
    GUVA = 2;
  }  
  else if (sensorValue < 83 ){
    GUVA = 3;
  }
  else if (sensorValue < 103 ){
    GUVA = 4;
  }
  else if (sensorValue < 124 ){
    GUVA = 5;
  }
  else if (sensorValue < 142 ){
    GUVA = 6;
  }
  else if (sensorValue < 162 ){
    GUVA = 7;
  }
  else if (sensorValue < 180 ){
    GUVA = 8;
  }
  else if (sensorValue < 200 ){
    GUVA = 9;
  }
  else if (sensorValue < 221 ){
    GUVA = 10;
  }
  else if (sensorValue > 240 ){
    GUVA = 11;
  }
  digitalWrite(led3, HIGH);
  delay(5);
  digitalWrite(led3, LOW);
}
void sendData(){
  digitalWrite(led4, HIGH);
  delay(5);
  digitalWrite(led4, LOW);
  /** SEND THE DATA **/
  Serial.print(STX);  
  Serial.print(MQ135, DEC);
  Serial.print(ETX);
  Serial.print(MQ7, DEC);
  Serial.print(ETX);
  Serial.print(GUVA, DEC);
  Serial.print(STX);
  Serial.print(EOT);
  Serial.print(EOT);
  Serial.println(EOT);
  
}
