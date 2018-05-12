///handle_freeMemory()

print(" -> handle_freeMemory()");

with (all) if (isPuzzleElement) handle_destroyThisObjectStacks(self);
with (par_surface) instance_destroy();
