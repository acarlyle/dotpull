///handle_destroyThisObjectStacks(this);

var objRef = argument0;

if (objRef.moveHistory)  ds_stack_destroy(objRef.moveHistory); 
if (objRef.movedDirHistory) ds_stack_destroy(objRef.movedDirHistory); 
if (objRef.stateHistory) ds_stack_destroy(objRef.stateHistory);

print("DESTROYED " + string(object_get_name(object_index)) + "'s stacks");
