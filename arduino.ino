#include <SoftwareSerial.h>
SoftwareSerial mySerial(6, 7);  // (Rx, Tx)

#include <LiquidCrystal.h>
LiquidCrystal lcd(13, 12, 11, 10, 9, 8);  // sets the interfacing pins

char i;
String num = "9363598586";

void setup() {
  lcd.begin(16, 2);
  lcd.setCursor(0, 0);
  lcd.clear();
  Serial.begin(9600); 
  mySerial.begin(9600); 
  pinMode(2, OUTPUT);
}

void loop() {
  while (Serial.available()) {
    i = Serial.read();
    Serial.println(i);
    delay(500);

    if (i == 'A') {
      digitalWrite(2, HIGH);
      delay(2000);
      digitalWrite(2, LOW);
      lcd.setCursor(0, 0);
      lcd.print("HIGH AFFECTED");
      Serial.println("HIGH AFFECTED STAGE");
      mySerial.println("AT\\r");
      delay(500);
      mySerial.println("AT+CMGF=1\\r");
      delay(500);
      mySerial.print("AT+CMGS=\"");
      mySerial.print(num);
      mySerial.println("\"\\r");
      delay(500);
      mySerial.print("HIGH AFFECTED STAGE");
      delay(1000);
      mySerial.println((char)26);
      delay(3000);
      lcd.clear();
    }

    if (i == 'B') {
      digitalWrite(2, HIGH);
      delay(2000);
      digitalWrite(2, LOW);
      lcd.setCursor(0, 0);
      lcd.print("MACULAR HOLE");
      Serial.println("MACULAR HOLE");
      mySerial.println("AT\\r");
      delay(500);
      mySerial.println("AT+CMGF=1\\r");
      delay(500);
      mySerial.print("AT+CMGS=\"");
      mySerial.print(num);
      mySerial.println("\"\\r");
      delay(500);
      mySerial.print("MACULAR HOLE");
      delay(1000);
      mySerial.println((char)26
