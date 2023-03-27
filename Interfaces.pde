interface Interacting {

  HashMap<String, AABBActor> acquiredActors = new HashMap();

  void onInteract(AABBActor invoker);

  default void acquire(AABBActor invoker) {
    acquiredActors.put(invoker.name, invoker);
  }
  default void drop(AABBActor invoker) { // not working dont use
    if (acquiredActors.containsKey(invoker.name)) {
      acquiredActors.remove(invoker.name);
    }
  }
}

interface Attacking { // not needed in this game

  void attack(float damage);
}
