import processing.sound.*;
SoundFile navigate;
SoundFile select;
//variables
String[] cityNames = new String[3];
int[] cityID = new int[3];
JSONObject jsonCurrentEd = new JSONObject();
JSONObject jsonCurrentCal = new JSONObject();
JSONObject jsonCurrentVan = new JSONObject();
JSONObject[] main = new JSONObject[3];
JSONArray[] weatherList = new JSONArray[3];
JSONObject[] weather = new JSONObject[3];
JSONObject[] wind = new JSONObject[3];
JSONObject[] sys = new JSONObject[3];
int[] dtUnix = new int[3];
float[] tempCurrent = new float[3];
float[] tempMin = new float[3];
float[] tempMax = new float[3];
float[] humid = new float[3];
String[] weatherDesc = new String[3];
float[] windSpd = new float[3];
int[] sunriseUnix = new int[3];
int[] sunsetUnix = new int[3];
String[] dtCurrent = new String[3];
JSONObject[] dtCurrentJSONObject = new JSONObject[3];
String[] dtReadable = new String[3];
String[] sunriseCurrent = new String[3];
JSONObject[] sunriseCurrentJSONObject = new JSONObject[3];
String[] sunriseReadable = new String[3];
String[] sunsetCurrent = new String[3];
JSONObject[] sunsetCurrentJSONObject = new JSONObject[3];
String[] sunsetReadable = new String[3];
int page = 3;
int menuCntrl = 0;
PImage sun;
PImage rain;
PImage cloud;
PImage snow;
PImage lightning;

void setup() {
  //setup area
  size(1251,600);
  println("start of console");
  navigate = new SoundFile(this,"navigate.wav");
  select = new SoundFile(this,"select.wav");
  
  sun = loadImage("sun.png");
  cloud = loadImage("cloud.png");
  rain = loadImage("rain.png");
  snow = loadImage("snow.png");
  lightning = loadImage("lightning.png");
  //basic variables
  cityNames[0] = "Edmonton";
  cityNames[1] = "Calgary";
  cityNames[2] = "Vancouver";
                      
  cityID[0] = 5946768;//Edmonton
  cityID[1] = 5913490;//Calgary
  cityID[2] = 6173331;//Vancouver
  //getting current weather info
  jsonCurrentEd = loadJSONObject("https://api.openweathermap.org/data/2.5/weather?id="+cityID[0]+"&APPID=0e09e71ebddea8d0a0eb6b1478e3039f&mode=JSON&units=metric");
  jsonCurrentCal = loadJSONObject("https://api.openweathermap.org/data/2.5/weather?id="+cityID[1]+"&APPID=0e09e71ebddea8d0a0eb6b1478e3039f&mode=JSON&units=metric");
  jsonCurrentVan = loadJSONObject("https://api.openweathermap.org/data/2.5/weather?id="+cityID[2]+"&APPID=0e09e71ebddea8d0a0eb6b1478e3039f&mode=JSON&units=metric");
  //unwraping
  main[0] = jsonCurrentEd.getJSONObject("main");//edmonton
  main[1] = jsonCurrentCal.getJSONObject("main");//calgary
  main[2] = jsonCurrentVan.getJSONObject("main");//vancouver
                     
  weatherList[0] = jsonCurrentEd.getJSONArray("weather");//edmonton
  weatherList[1] = jsonCurrentCal.getJSONArray("weather");//calgary
  weatherList[2] = jsonCurrentVan.getJSONArray("weather");//vancouver
                        
  weather[0] = weatherList[0].getJSONObject(0);//edmonton
  weather[1] = weatherList[1].getJSONObject(0);
  weather[2] = weatherList[2].getJSONObject(0);
                        
  wind[0] = jsonCurrentEd.getJSONObject("wind");//edmonton
  wind[1] = jsonCurrentCal.getJSONObject("wind");//calgary
  wind[2] = jsonCurrentVan.getJSONObject("wind");//vancouver
                     
  sys[0] = jsonCurrentEd.getJSONObject("sys");//edmonton
  sys[1] = jsonCurrentCal.getJSONObject("sys");//calgary
  sys[2] = jsonCurrentVan.getJSONObject("sys");//vancouver

                     
  //getting info
  dtUnix[0] = jsonCurrentEd.getInt("dt");//edmonton
  dtUnix[1] = jsonCurrentCal.getInt("dt");//calgary
  dtUnix[2] = jsonCurrentVan.getInt("dt");//vancouver
            
  tempCurrent[0] = main[0].getFloat("temp");//edmonton
  tempCurrent[1] = main[1].getFloat("temp");//calgary
  tempCurrent[2] = main[2].getFloat("temp");//vancouver
                       
  tempMin[0] = main[0].getFloat("temp_min");//edmonton
  tempMin[1] = main[1].getFloat("temp_min");//calgary
  tempMin[2] = main[2].getFloat("temp_min");//vancouver
                   
  tempMax[0] = main[0].getFloat("temp_max");//edmonton
  tempMax[1] = main[1].getFloat("temp_max");//calgary
  tempMax[2] = main[2].getFloat("temp_max");//vancouver
                   
  humid[0] = main[0].getFloat("humidity");//edmonton
  humid[1] = main[1].getFloat("humidity");//calgary
  humid[2] = main[2].getFloat("humidity");//vancouver
                   
  weatherDesc[0] = weather[0].getString("description");//edmonton
  weatherDesc[1] = weather[1].getString("description");//calgary
  weatherDesc[2] = weather[2].getString("description");//vancouver
                        
  windSpd[0] = wind[0].getFloat("speed");//edmonton
  windSpd[1] = wind[1].getFloat("speed");//calgary
  windSpd[2] = wind[2].getFloat("speed");//vancouver
                   
  sunriseUnix[0] = sys[0].getInt("sunrise");//edmonton
  sunriseUnix[1] = sys[1].getInt("sunrise");//calgary 
  sunriseUnix[2] = sys[2].getInt("sunrise");//vancouver
                 
  sunsetUnix[0] = sys[0].getInt("sunset");//edmonton
  sunsetUnix[1] = sys[1].getInt("sunset");//calgary 
  sunsetUnix[2] = sys[2].getInt("sunset");//vancouver
                 
  //converting unix to readable time

  //dt
  dtCurrent[0] = "http://convert-unix-time.com/api?timestamp=" + dtUnix[0] + "&timezone=Edmonton";//edmonton
  dtCurrent[1] = "http://convert-unix-time.com/api?timestamp=" + dtUnix[1] + "&timezone=Edmonton";//calgary
  dtCurrent[2] = "http://convert-unix-time.com/api?timestamp=" + dtUnix[2] + "&timezone=Vancouver";//vancouver
  
  dtCurrentJSONObject[0] = loadJSONObject(dtCurrent[0]);//edmonton
  dtCurrentJSONObject[1] = loadJSONObject(dtCurrent[1]);//calgary
  dtCurrentJSONObject[2] = loadJSONObject(dtCurrent[2]);//vancouver
  
  dtReadable[0] = dtCurrentJSONObject[0].getString("localDate");//edmonton
  dtReadable[1] = dtCurrentJSONObject[1].getString("localDate");//calgary
  dtReadable[2] = dtCurrentJSONObject[2].getString("localDate");//vancouver
                       
  //sunrise
  sunriseCurrent[0] = "http://convert-unix-time.com/api?timestamp=" + sunriseUnix[0] + "&timezone=Edmonton";//edmonton
  sunriseCurrent[1] = "http://convert-unix-time.com/api?timestamp=" + sunriseUnix[1] + "&timezone=Edmonton";//calgary
  sunriseCurrent[2] = "http://convert-unix-time.com/api?timestamp=" + sunriseUnix[2] + "&timezone=Vancouver";//vancouver
  
  sunriseCurrentJSONObject[0] = loadJSONObject(sunriseCurrent[0]);//edmonton
  sunriseCurrentJSONObject[1] = loadJSONObject(sunriseCurrent[1]);//calgary
  sunriseCurrentJSONObject[2] = loadJSONObject(sunriseCurrent[2]);//vancouver
  
  sunriseReadable[0] = sunriseCurrentJSONObject[0].getString("localDate");//edmonton
  sunriseReadable[0] = sunriseCurrentJSONObject[1].getString("localDate");//calgary
  sunriseReadable[0] = sunriseCurrentJSONObject[2].getString("localDate");//vancouver
  //sunset
  sunsetCurrent[0] = "http://convert-unix-time.com/api?timestamp=" + sunsetUnix[0] + "&timezone=Edmonton";//edmonton
  sunsetCurrent[1] = "http://convert-unix-time.com/api?timestamp=" + sunsetUnix[1] + "&timezone=Edmonton";//calgary
  sunsetCurrent[2] = "http://convert-unix-time.com/api?timestamp=" + sunsetUnix[2] + "&timezone=Vancouver";//vancouver
  
  sunsetCurrentJSONObject[0] = loadJSONObject(sunsetCurrent[0]);//edmonton
  sunsetCurrentJSONObject[1] = loadJSONObject(sunsetCurrent[1]);//calgary
  sunsetCurrentJSONObject[2] = loadJSONObject(sunsetCurrent[2]);//vancouver
  
  sunsetReadable[0] = sunsetCurrentJSONObject[0].getString("localDate");//edmonton
  sunsetReadable[0] = sunsetCurrentJSONObject[1].getString("localDate");//calgary
  sunsetReadable[0] = sunsetCurrentJSONObject[2].getString("localDate");//vancouver

  //printing to cmd line

  //edmonton
  println(cityNames[0]);//name
  println(dtReadable[0]);//date/time
  println("sunrise:"+sunriseReadable[0]);//sunrise
  println("sunset:"+sunsetReadable[0]);//sunset
  println("weather:"+weatherDesc[0]);
  println("temp:"+tempCurrent[0]);//current temperature
  println("min:"+tempMin[0]);//minimum temperature
  println("max:"+tempMax[0]);//minimum temperature
  println("humidity:"+humid[0]);//humidity
  println("wind speed:"+windSpd[0]);//wind speed

  //calgary
  println(cityNames[1]);//name
  println(dtReadable[1]);//date/time
  println("sunrise:"+sunriseReadable[1]);//sunrise
  println("sunset:"+sunsetReadable[1]);//sunset
  println("weather:"+weatherDesc[1]);
  println("temp:"+tempCurrent[1]);//current temperature
  println("min:"+tempMin[1]);//minimum temperature
  println("max:"+tempMax[1]);//minimum temperature
  println("humidity:"+humid[1]);//humidity
  println("wind speed:"+windSpd[1]);//wind speed

  //Vancouver
  println(cityNames[2]);//name
  println(dtReadable[2]);//date/time
  println("sunrise:"+sunriseReadable[2]);//sunrise
  println("sunset:"+sunsetReadable[2]);//sunset
  println("weather:"+weatherDesc[2]);
  println("temp:"+tempCurrent[2]);//current temperature
  println("min:"+tempMin[2]);//minimum temperature
  println("max:"+tempMax[2]);//minimum temperature
  println("humidity:"+humid[2]);//humidity
  println("wind speed:"+windSpd[2]);//wind speed
}

void draw() {
  mainMenu(menuCntrl);
  if (page==0) {
    EdmontonPage();
  }else if (page == 1) {
    CalgaryPage();
  }else if (page == 2) {
   VancouverPage(); 
  }
}

void keyPressed() {
  if (keyPressed) {
    if (keyCode==UP){
      if(page == 3) {
        if(menuCntrl<=0){
          
          menuCntrl=3;
          navigate.play();
        }else{
          menuCntrl--;
          navigate.play();
        }
      }
    }
    if (keyCode == DOWN) {
      if(page == 3) {
        if(menuCntrl>=3){
          
          menuCntrl=0;
          navigate.play();
        }else{
          menuCntrl++;
          navigate.play();
        }
      } 
    }
    if (keyCode ==ENTER) {
      if(page==3){
        if(menuCntrl==0){
         page = 0;
         select.play();
        }
        if(menuCntrl==1){
         page = 1;
         select.play();
        }
        if(menuCntrl==2){
         page = 2;
        select.play();
        }
        if(menuCntrl==3){
         exit();
         select.play();
        }
      }
    }
    
    if (keyCode == BACKSPACE){
      if (page != 3) {
       page = 3;
       select.play();
      }
    }
  }
}

void  mainMenu(int menuCntrl){
  rectMode(CORNERS);
  fill(#3CC2DB);
  rect(0,0,1250,599);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  fill(0);
  textSize(50);
  text("Weather Program",width/5,50);
  text("Instructions:",width*17/20,50);
  textSize(30);
  text("Up Arrow = Move Up",width*17/20,100);
  text("Down Arrow = Move Down",width*21/25,145);
  text("Enter = Select",width*17/20,190);
  text("Backspace = Go Back",width*17/20,235);
  textAlign(CENTER,LEFT);
  
  if(menuCntrl == 0) {
    textSize(40);
    fill(#FF5500);
  }else{
    textSize(35);
    fill(0);
  }
  text(cityNames[0],width/9.5,120);
  if(menuCntrl == 1) {
    textSize(40);
    fill(#FF5500);
  }else{
    textSize(35);
    fill(0);
  }
  text(cityNames[1],width/11.5,165);
  if(menuCntrl == 2) {
    textSize(40);
    fill(#FF5500);
  }else{
    textSize(35);
    fill(0);
  }
  text(cityNames[2],width/9.5,210);
  if(menuCntrl == 3) {
    textSize(40);
    fill(#FF5500);
  }else{
    textSize(35);
    fill(0);
  }
  text("Quit",width/15,255);
}

void EdmontonPage() {
  rectMode(CORNERS);
  fill(#3CC2DB);
  rect(0,0,1250,599);
  rectMode(CENTER);
  textAlign(LEFT,CENTER);
  fill(0);
  textSize(50);
  text(cityNames[0],width/32,50);
  textSize(35);
  text("Date and Time: "+dtReadable[0],width/32,100);
  text("Weather: "+weatherDesc[0],width/32,145);
  text("Current Temperature: "+tempCurrent[0]+"C",width/32,190);
  text("Minimum Temperature: "+tempMin[0]+"C",width/32,235);
  text("Maximum Temperature: "+tempMax[0]+"C",width/32,280);
  text("Humidity: "+humid[0]+"%",width/32,325);
  text("Wind Speed: "+windSpd[0]+"m/s",width/32,370);
  text("Sunrise Time: "+sunriseReadable[0],width/32,415);
  text("Sunset Time: "+sunsetReadable[0],width/32,460);
  
  if(weatherDesc[0].equals("thunderstorm with light rain") == true || weatherDesc[0].equals("thunderstorm with rain") == true || weatherDesc[0].equals("thunderstorm with heavy rain") == true || weatherDesc[0].equals("light thunderstorm") == true || weatherDesc[0].equals("thunderstorm") == true || weatherDesc[0].equals("heavy thunderstorm") == true || weatherDesc[0].equals("ragged thunderstorm") == true || weatherDesc[0].equals("thunderstorm with light drizzle") == true || weatherDesc[0].equals("thunderstorm with drizzle") == true || weatherDesc[0].equals("thunderstorm with heavy drizzle") == true ) {
    image(lightning,300,15);
  }else if (weatherDesc[0].equals("light intensity drizzle") == true || weatherDesc[0].equals("drizzle") == true || weatherDesc[0].equals("heavy intensity drizzle") == true || weatherDesc[0].equals("light intensity drizzle rain") == true || weatherDesc[0].equals("drizzle rain") == true || weatherDesc[0].equals("heavy intensity drizzle rain") == true || weatherDesc[0].equals("shower rain and drizzle") == true || weatherDesc[0].equals("heavy shower rain and drizzle") == true || weatherDesc[0].equals("shower drizzle") == true || weatherDesc[0].equals("light rain") == true || weatherDesc[0].equals("moderate rain") == true || weatherDesc[0].equals("heavy intensity rain") == true || weatherDesc[0].equals("very heavy rain") == true || weatherDesc[0].equals("extreme rain") == true || weatherDesc[0].equals("freezing rain") == true || weatherDesc[0].equals("light intensity shower rain") ==true  || weatherDesc[0].equals("shower rain") ==true  || weatherDesc[0].equals("heavy intensity shower rain") ==true  || weatherDesc[0].equals("ragged shower rain") == true){
   image(rain,300,15); 
  }else if (weatherDesc[0].equals("light snow") == true || weatherDesc[0].equals("snow") == true || weatherDesc[0].equals("heavy snow") == true || weatherDesc[0].equals("sleet") == true || weatherDesc[0].equals("shower sleet") == true || weatherDesc[0].equals("light rain and snow") == true || weatherDesc[0].equals("rain and snow") == true || weatherDesc[0].equals("light shower snow") == true || weatherDesc[0].equals("shower and snow") == true || weatherDesc[0].equals("heavy shower and snow") == true){
    image(snow,300,15);
  }else if (weatherDesc[0].equals("few clouds") == true || weatherDesc[0].equals("scattered clouds") == true || weatherDesc[0].equals("broken clouds") == true || weatherDesc[0].equals("overcast clouds") == true) {
    image(cloud,300,15);
  }else if(weatherDesc[0].equals("clear sky")==true){
   image(sun,300,15); 
  }
}

void CalgaryPage() {
  rectMode(CORNERS);
  fill(#3CC2DB);
  rect(0,0,1250,599);
  rectMode(CENTER);
  textAlign(LEFT,CENTER);
  fill(0);
  textSize(50);
  text(cityNames[1],width/32,50);
  textSize(35);
  text("Date and Time: "+dtReadable[1],width/32,100);
  text("Weather: "+weatherDesc[1],width/32,145);
  text("Current Temperature: "+tempCurrent[1]+"C",width/32,190);
  text("Minimum Temperature: "+tempMin[1]+"C",width/32,235);
  text("Maximum Temperature: "+tempMax[1]+"C",width/32,280);
  text("Humidity: "+humid[1]+"%",width/32,325);
  text("Wind Speed: "+windSpd[1]+"m/s",width/32,370);
  text("Sunrise Time: "+sunriseReadable[1],width/32,415);
  text("Sunset Time: "+sunsetReadable[1],width/32,460);
  
  if(weatherDesc[1].equals("thunderstorm with light rain") == true || weatherDesc[1].equals("thunderstorm with rain") == true || weatherDesc[1].equals("thunderstorm with heavy rain") == true || weatherDesc[1].equals("light thunderstorm") == true || weatherDesc[1].equals("thunderstorm") == true || weatherDesc[1].equals("heavy thunderstorm") == true || weatherDesc[1].equals("ragged thunderstorm") == true || weatherDesc[1].equals("thunderstorm with light drizzle") == true || weatherDesc[1].equals("thunderstorm with drizzle") == true || weatherDesc[1].equals("thunderstorm with heavy drizzle") == true ) {
    image(lightning,300,15);
  }else if (weatherDesc[1].equals("light intensity drizzle") == true || weatherDesc[1].equals("drizzle") == true || weatherDesc[1].equals("heavy intensity drizzle") == true || weatherDesc[1].equals("light intensity drizzle rain") == true || weatherDesc[1].equals("drizzle rain") == true || weatherDesc[1].equals("heavy intensity drizzle rain") == true || weatherDesc[1].equals("shower rain and drizzle") == true || weatherDesc[1].equals("heavy shower rain and drizzle") == true || weatherDesc[1].equals("shower drizzle") == true || weatherDesc[1].equals("light rain") == true || weatherDesc[1].equals("moderate rain") == true || weatherDesc[1].equals("heavy intensity rain") == true || weatherDesc[1].equals("very heavy rain") == true || weatherDesc[1].equals("extreme rain") == true || weatherDesc[1].equals("freezing rain") == true || weatherDesc[1].equals("light intensity shower rain") ==true  || weatherDesc[1].equals("shower rain") ==true  || weatherDesc[1].equals("heavy intensity shower rain") ==true  || weatherDesc[1].equals("ragged shower rain") == true){
   image(rain,300,15); 
  }else if (weatherDesc[1].equals("light snow") == true || weatherDesc[1].equals("snow") == true || weatherDesc[1].equals("heavy snow") == true || weatherDesc[1].equals("sleet") == true || weatherDesc[1].equals("shower sleet") == true || weatherDesc[1].equals("light rain and snow") == true || weatherDesc[1].equals("rain and snow") == true || weatherDesc[1].equals("light shower snow") == true || weatherDesc[1].equals("shower and snow") == true || weatherDesc[1].equals("heavy shower and snow") == true){
    image(snow,300,15);
  }else if (weatherDesc[1].equals("few clouds") == true || weatherDesc[1].equals("scattered clouds") == true || weatherDesc[1].equals("broken clouds") == true || weatherDesc[1].equals("overcast clouds") == true) {
    image(cloud,230,15);
  }else if(weatherDesc[1].equals("clear sky")==true){
   image(sun,300,15); 
  }
}

void VancouverPage() {
  rectMode(CORNERS);
  fill(#3CC2DB);
  rect(0,0,1250,599);
  rectMode(CENTER);
  textAlign(LEFT,CENTER);
  fill(0);
  textSize(50);
  text(cityNames[2],width/32,50);
  textSize(35);
  text("Date and Time: "+dtReadable[0],width/32,100);
  text("Weather: "+weatherDesc[2],width/32,145);
  text("Current Temperature: "+tempCurrent[2]+"C",width/32,190);
  text("Minimum Temperature: "+tempMin[2]+"C",width/32,235);
  text("Maximum Temperature: "+tempMax[2]+"C",width/32,280);
  text("Humidity: "+humid[2]+"%",width/32,325);
  text("Wind Speed: "+windSpd[2]+"m/s",width/32,370);
  text("Sunrise Time: "+sunriseReadable[2],width/32,415);
  text("Sunset Time: "+sunsetReadable[2],width/32,460);
  
  if(weatherDesc[2].equals("thunderstorm with light rain") == true || weatherDesc[2].equals("thunderstorm with rain") == true || weatherDesc[2].equals("thunderstorm with heavy rain") == true || weatherDesc[2].equals("light thunderstorm") == true || weatherDesc[2].equals("thunderstorm") == true || weatherDesc[2].equals("heavy thunderstorm") == true || weatherDesc[2].equals("ragged thunderstorm") == true || weatherDesc[2].equals("thunderstorm with light drizzle") == true || weatherDesc[2].equals("thunderstorm with drizzle") == true || weatherDesc[2].equals("thunderstorm with heavy drizzle") == true ) {
    image(lightning,300,15);
  }else if (weatherDesc[2].equals("light intensity drizzle") == true || weatherDesc[2].equals("drizzle") == true || weatherDesc[2].equals("heavy intensity drizzle") == true || weatherDesc[2].equals("light intensity drizzle rain") == true || weatherDesc[2].equals("drizzle rain") == true || weatherDesc[2].equals("heavy intensity drizzle rain") == true || weatherDesc[2].equals("shower rain and drizzle") == true || weatherDesc[2].equals("heavy shower rain and drizzle") == true || weatherDesc[2].equals("shower drizzle") == true || weatherDesc[2].equals("light rain") == true || weatherDesc[2].equals("moderate rain") == true || weatherDesc[2].equals("heavy intensity rain") == true || weatherDesc[2].equals("very heavy rain") == true || weatherDesc[2].equals("extreme rain") == true || weatherDesc[2].equals("freezing rain") == true || weatherDesc[2].equals("light intensity shower rain") ==true  || weatherDesc[2].equals("shower rain") ==true  || weatherDesc[2].equals("heavy intensity shower rain") ==true  || weatherDesc[2].equals("ragged shower rain") == true){
   image(rain,300,15); 
  }else if (weatherDesc[2].equals("light snow") == true || weatherDesc[2].equals("snow") == true || weatherDesc[2].equals("heavy snow") == true || weatherDesc[2].equals("sleet") == true || weatherDesc[2].equals("shower sleet") == true || weatherDesc[2].equals("light rain and snow") == true || weatherDesc[2].equals("rain and snow") == true || weatherDesc[2].equals("light shower snow") == true || weatherDesc[2].equals("shower and snow") == true || weatherDesc[2].equals("heavy shower and snow") == true){
    image(snow,300,15);
  }else if (weatherDesc[2].equals("few clouds") == true || weatherDesc[2].equals("scattered clouds") == true || weatherDesc[2].equals("broken clouds") == true || weatherDesc[2].equals("overcast clouds") == true) {
    image(cloud,300,15);
  }else if(weatherDesc[2].equals("clear sky")==true){
   image(sun,300,15); 
  }
}