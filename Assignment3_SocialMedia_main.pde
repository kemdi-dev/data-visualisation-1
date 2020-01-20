/*
 * Kemdi Ikejiani
 * Course: DATT 3935
 * Social Media App Visualisation for Assignment 3
 * 
 * 
 */ 

Table table;
String file = "assignment3updated.csv"; 
//UnfoldingMap map;
ArrayList<Data> info = new ArrayList();
//PImage img;

int clicked_at_x;
int clicked_at_y;
boolean was_clicked = false;

void setup() {  
  table = loadTable("assignment3updated.csv", "header");
  size(900, 700, P3D);
  smooth();
  noLoop();
  
  
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
    
    info.add(data);
    
  }  
}

void draw() {
  background(255);
  imageMode(CORNER); 
  noTint();
  noStroke();
  
  String s = "Data Visualization of Mobile Use of Five Different Social Media Apps: Twitter, Facebook, Snapchat, Instagram, Reddit";
  textSize(14);
  fill(100);
  text(s, 14, height - 20);
  
  PImage img;
  img = loadImage("legenda3.png");
  image(img, 0, height - 80);
  
  for (TableRow data : table.rows()) {
    
    int reddit = data.getInt("Reddit");
    int twitter = data.getInt("Twitter");
    float snapchat = data.getInt("Snapchat");
    float instagram = data.getInt("Instagram");
    int facebook = data.getInt("Facebook");
    String days = data.getString("Days");
    int stress = data.getInt("Stress Level");
    
    //println("reddit: " + reddit + "and facebook: " + facebook);
    
    float stressLev = map(stress, 1, 5, 100, 230);
    
    float lng = data.getInt("Long");
    float redHeight;
    /*float faceHeight;
    float twitHeight;
    float snapHeight;
    float instHeight;*/
    
    if (reddit == 0) {
      redHeight = 0;
    } else {
      redHeight = reddit * 3;
    }
    noStroke();
    fill(89, 179, 236, 180);
    rect(stressLev + (instagram*3) + (snapchat*3) + (facebook * 3) + (reddit * 3), lng * 3, twitter * 3, twitter);
    
    fill(212, 46, 46, stressLev);
    rect(stressLev + (instagram*3) + (snapchat*3) + (facebook * 3), lng * 3, redHeight, reddit);
    
    fill(28, 88, 209, stressLev);
    rect(stressLev + (instagram*3) + (snapchat*3), lng * 3, facebook * 3, facebook);
    /*String faceText = "Facebook: " + facebook + " mins";
    textSize(12);
    fill(100);
    text(faceText, 0, lng*3 + 32);*/
    
    
    fill(243, 135, 38, stressLev);
    rect(stressLev + snapchat * 3, lng * 3, instagram * 3, instagram);
    /*String instText = "Instagram: " + instagram + " mins";
    textSize(12);
    fill(100);
    text(instText, 0, lng*3 + 44);*/
    
    fill(242, 236, 76, stressLev);
    rect(stressLev, lng * 3, snapchat * 3, snapchat);
    
    /*stroke(0);
    strokeWeight(0.5);
    line(0, lng * 3, width, lng * 3);*/
    
    /*if(was_clicked){
      stroke(0);
      strokeWeight(0.5);
      line(clicked_at_x, clicked_at_y, width, lng * 3);
    }*/
    
  }
}

void mouseClicked() {
  was_clicked = true;
  clicked_at_x = mouseX;
  clicked_at_y = mouseY;
}
