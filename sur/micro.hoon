|%
+$  id  @da
+$  priority  @ud
+$  apps  (set =path)
+$  new  (set [=id =path =priority])
+$  action  
  $%  [%link =path]
      [%bump =path =priority]
      [%view app=[=id =path =priority]]
  ==
--