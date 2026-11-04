String[] GENRES = { "MMA", "Comedy", "Hip-hop", "R&B" };
StringList artists = new StringList();
int[] GENRE_COLORS = {
  color(255, 0, 0),
  color(0, 255, 100),
  color(0, 100, 255),
  color(255, 0, 255)
};
int[] counts = new int[4];

float podHours = 0;
float songHours = 0;

void setup() {
  size(800,800);
  noLoop();

  Table table = loadTable("dearDataProject.csv", "header");
  for (TableRow row : table.rows()) {
    String[] genres = split(row.getString(5), ',');
    for (int g = 0; g < genres.length; g++) {
      String name = trim(genres[g]);
      for (int i = 0; i < GENRES.length; i++) {
        if (GENRES[i].equals(name)) counts[i]++;
      }
    }
    String time = row.getString(1);
    String [] match = match(time, "(\\d{1,2})\\D+(\\d{1,2})");
    int start = int(match[1]);
    int end = int(match[2]);
    int hours = end - start;
    println(time + " | pod: [" + row.getString(3) + "] | " + hours);
    if (hours<0) hours = hours + 12;
    
    String pod = row.getString(3);
    if (trim(pod).length() > 0) {
      podHours += hours;
    } else {
      songHours += hours;
    }
    String[] artistNames = split(row.getString(4), ',');
    for (String name : artistNames) {
      String artist = trim(name);
      if (artist.length() > 0 && !artists.hasValue(artist)) {
        artists.append(artist);
      }
    }
    
  }
}

void draw() {
  background(255);
  int biggest = max(counts);

  fill(0);
  textAlign(CENTER);
  textSize(14);
  text("Number of sessions per genre", width / 2, 30);

  for (int i = 0; i < GENRES.length; i++) {
    float h = map(counts[i], 0, biggest, 0, 250);
    float x = 80 + i * 120;

    stroke(0);
    fill(GENRE_COLORS[i]);
    rect(x, 330 - h, 80, h);

    fill(0);
    text(GENRES[i], x + 40, 355);
    text(counts[i], x + 40, 320 - h);
  }
  text("Podcasts", 180, 385);
  text("Songs", 420, 385);
  
  float biggestHours = max(podHours, songHours);
  float podBar = map(podHours, 0, biggestHours, 0, 220);
  float songBar = map(songHours, 0, biggestHours, 0, 220);
  
  fill(0);
  text("Hours listened: podcasts vs songs (hours)", width / 2, 450);
  
  noStroke();
  fill(0,255,255);
  rect(160, 730 - podBar, 100, podBar);
  fill(150,100,255);
  rect(340,730 - songBar,100, songBar);
  
  fill(0);
  text("Podcasts", 210, 755);
  text("Songs", 390, 755);
  text(podHours, 210, 720 - podBar);
  text(songHours, 390, 720 - songBar);
  
  fill(0);
  textAlign(LEFT);
  text("Artists listened to:", 580, 230);
  for (int i=0; i<artists.size(); i++) {
    text(artists.get(i), 580,260 + i *18);
  }
  textAlign(LEFT);
}
  
