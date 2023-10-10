|%
+$  id  @t
+$  county  (map ship=@p value=@t)  :: state has counties
+$  app  [ui=@t =county transforms=(set transform)]
+$  apps  (map =id =app)
+$  transform
  $%  %add
      %replace-text
  ==
+$  action
  $%  [%replace-text text=@t]
      [%add num=@ud]
  ==
--