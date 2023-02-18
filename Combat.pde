class Combat extends Component {
  
  // fields
  AABBActor parent;
  float dmgStart = 1;
  float hpStart = 3;
  float kbStart = 1;
  float hp = 0;
  float dmg = 0;
  float knockback = 0;  
  boolean isDamageable = true;
  boolean knockbackEnabled = true;
  
  Combat(AABBActor parent){
    
    name = "combat";
    
    this.parent = parent;
  }
  
  Combat(AABBActor parent, float dmgStart, float hpStart, float kbStart){
    
    name = "combat";
    
    this.parent = parent;
    this.dmgStart = dmgStart;
    this.hpStart = hpStart;
    this.kbStart = kbStart;
    hp = hpStart;
    dmg = dmgStart;
    knockback = kbStart;
    
  }

  void update() {
  }

  void draw() {
  }
  
  void takeDamage(String dealer, float incDmg){
  
    hp -= incDmg;
    if (hp <= 0) {
      death(dealer);
    }
    println(incDmg + " damage taken! " + hp + "health left!");
  }
  
  void knockback(float knockback){
  }
  
  void death(String victor){
    println(parent.name + " was killed by " + victor + "!");
  }
}
