bool checkCollision(actor1, actor2) {
  // check if actor1 collider overlaps actor2 collider using flame overlap method
  if (actor1.toRect().overlaps(actor2.toRect())) {
    return true;
  }

  return false;
}
