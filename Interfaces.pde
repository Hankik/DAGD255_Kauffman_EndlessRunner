interface Interacting {
  
  void interact(AABBActor invoker);
}

interface Attacking {

  void attack(float damage, float knockback);
}
