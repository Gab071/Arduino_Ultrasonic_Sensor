#include <Servo.h> 

#define trigPin 12
#define echoPin 11
#define serv 8
 
Servo servoMotor;   

int CalculateDistance();
void PositionInfo(int index);

 
void setup() 
{ 
  servoMotor.attach(serv); 
  Serial.begin(9600); 
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
} 
 
void loop() 
{  
  for(int i=0; i < 180; i++)
  {
    PositionInfo(i);
  }     
  for(int i=180; i > 0; i--)      
  {
    PositionInfo(i);
  }
}

void PositionInfo(int index)
{
    servoMotor.write(index);
    delay(20);
    Serial.print(index);
    Serial.print(", ");
    Serial.print(CalculateDistance());
    Serial.println(".");
}

int CalculateDistance() 
{
  long time, distance;
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  time = pulseIn(echoPin, HIGH);
  distance = time / 58;
  return distance;
}