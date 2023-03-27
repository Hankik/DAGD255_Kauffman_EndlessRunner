// a class for keeping track an actor's distinct state
class Progression extends Component {

  // fields
  AABBActor parent;
  ArrayList<Boolean> tiers = new ArrayList();
  int currentTier = 0;
  boolean complete = false;

  Progression(AABBActor parent, boolean[] addedTiers) {

    name = "progression";

    setVisibility(false);

    this.parent = parent;

    for (int i = 0; i < addedTiers.length; i++) tiers.add(addedTiers[i]);
  }

  Progression(AABBActor parent) {

    name = "progression";
    this.parent = parent;
  }

  void setupProgression(boolean[] addedTiers) {
    for (int i = 0; i < addedTiers.length; i++) tiers.add(addedTiers[i]);
  }

  void progressTier() {
    tiers.set(currentTier, true);
    if (complete == false) currentTier = findIncomplete();
    if (currentTier == -1) {
      complete = true;
      currentTier = tiers.size()-1;
    }
  }

  int findIncomplete() {

    for (int i = 0; i < tiers.size(); i++) if (!tiers.get(i)) return i;
    return -1;
  }

  void setCurrentTier(int newTier) {
    currentTier = newTier;
  }

  void update() {
  }

  void draw() {
    if (isVisible) {
      pushMatrix();
      fill(BLACK);
      translate(parent.x, parent.y);
      text("Current tier: " + currentTier, 0, -parent.h);
      popMatrix();
    }
  }
}
