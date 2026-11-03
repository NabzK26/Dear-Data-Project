String[] GENRES = { "MMA", "Comedy", "Hip-hop", "R&B" };
int[] GENRE_COLORS = {
  color(255, 0, 0),
  color(0, 255, 100),
  color(0, 100, 255),
  color(255, 0, 255)
};
int[] counts = new int[4];

void setup() {
  size(600, 400);
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
}
