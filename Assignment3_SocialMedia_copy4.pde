/*
 * Kemdi Ikejiani
 * Social Media App Visualisation for Assignment 2
 * 
 * 
 */ 
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
Table table;
String file = "assignment3updated.csv"; 
//UnfoldingMap map;
ArrayList<Data> info = new ArrayList();
//PImage img;

ArrayList<Float> one = new ArrayList<Float> ();
ArrayList<Float> two = new ArrayList<Float> ();

int clicked_at_x;
int clicked_at_y;
boolean was_clicked = false;

void setup() {  
  table = loadTable("assignment3updated.csv", "header");
  size(900, 700, P3D);
  smooth();
  noLoop();
  
  String s = "Data Visualization of Mobile Use of Five Different Social Media Apps";
  textSize(16);
  fill(100);
  text(s, width/2,height/2);
  
  Table dataCSV = loadTable(file, "header, csv");
  for (TableRow dataRow : dataCSV.rows()) {
    // Create new empty object to store data
    Data data = new Data();

    // Read data from CSV
    data.id = dataRow.getString("Days");
    //data.index = dataRow.getInt("aqi");
    
    data.twitter = dataRow.getInt("Twitter");
    data.reddit = dataRow.getInt("Reddit");
    data.facebook = dataRow.getInt("Facebook");
    data.instagram = dataRow.getInt("Instagram");
    data.snapchat = dataRow.getInt("Snapchat");
    data.stress = dataRow.getInt("Stress Level");
    //data.totalWidth = dataRow.getFloat();
    
    data.lat = dataRow.getInt("Lat");
    data.lng = dataRow.getInt("Long");
    
    info.add(data);
    
  }  
}

void draw() {
  background(255);
   // Initalize colour and map position
  imageMode(CORNER); 
  noTint();
  noStroke();
  String s = "Data Visualization of Mobile Use of Five Different Social Media Apps: Twitter, Facebook, Snapchat, Instagram, Reddit";
  textSize(14);
  fill(100);
  text(s, 20, height - 20);
  
  for (TableRow data : table.rows()) {
    
    int reddit = data.getInt("Reddit");
    int twitter = data.getInt("Twitter");
    float snapchat = data.getInt("Snapchat");
    float instagram = data.getInt("Instagram");
    int facebook = data.getInt("Facebook");
    
    String days = data.getString("Days");
    
    int stress = data.getInt("Stress Level");
    
    println("reddit: " + reddit + "and facebook: " + facebook);
    
    float stressLev = map(stress, 1, 5, 100, 230);
    
    
    float lng = data.getInt("Long");
    float redHeight;
    float faceHeight;
    float twitHeight;
    float snapHeight;
    float instHeight;
    
    if (reddit == 0) {
      redHeight = 0;
    } else {
      redHeight = reddit * 3;
    }
    
    fill(89, 179, 236, 180);
    rect(stressLev + (instagram*3) + (snapchat*3) + (facebook * 3) + (reddit * 3), lng * 3, twitter * 3, twitter);
    
    fill(212, 46, 46, stressLev);
    rect(stressLev + (instagram*3) + (snapchat*3) + (facebook * 3), lng * 3, redHeight, reddit);
    
    fill(28, 88, 209, stressLev);
    rect(stressLev + (instagram*3) + (snapchat*3), lng * 3, facebook * 3, facebook);
    
    fill(243, 135, 38, stressLev);
    rect(stressLev + snapchat * 3, lng * 3, instagram * 3, instagram);
    
    fill(242, 236, 76, stressLev);
    rect(stressLev, lng * 3, snapchat * 3,snapchat);
    
    /*if(was_clicked){
      if (clicked_at_x > stressLev && clicked_at_x < ((lng *3) + 5)) {
        ellipse (lng *3, 20, 10, 10);
      } else {
      rect(clicked_at_x, clicked_at_y,50,50);
      }
    }*/
    
  }
}

void mouseClicked() {
  was_clicked = true;
  clicked_at_x = mouseX;
  clicked_at_y = mouseY;
}
