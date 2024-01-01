bool checkCollision(actor1, actor2) {
  if (actor1.position.x < actor2.position.x + actor2.width &&
      actor1.position.x + actor1.width > actor2.position.x &&
      actor1.position.y < actor2.position.y + actor2.height &&
      actor1.height + actor1.position.y > actor2.position.y) {
    return true;
  }

  return false;
}
