|%
+$  id  @da
+$  priority  @ud
+$  apps  (set =path)
+$  new  (set [=id =path =priority])
+$  ignored  (set agent=@tas)
+$  action  
  $%  [%link =path]
      [%unlink =path]
      [%bump =path =priority]
      [%view app=[=id =path =priority]]
      [%view-all ~]
      [%ignore agent=@tas]
      [%unignore agent=@tas]
  ==
--