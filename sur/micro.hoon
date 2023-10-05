|%
+$  id  @da
+$  url  @t
+$  priority  @ud
+$  apps  (set =url)
+$  new  (set =url)
+$  ignored  (set agent=@tas)
+$  action  
  $%  [%link =url]
      [%unlink =url]
      [%bump =url]
      [%view =url]
      [%view-all ~]
      [%ignore agent=@tas]
      [%unignore agent=@tas]
  ==
--