/-  doodle, pals
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/uis/doodle/html
/*  view-ui  %html  /app/uis/doodle-view/html
/*  gallery-ui  %html  /app/uis/doodle-gallery/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =gallery:doodle]
::
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-0
=*  state  -
::
^-  agent:gall
::
=<
|_  =bowl:gall
+*  this  .
    def  ~(. (default-agent this %|) bowl)
    hc   ~(. +> [bowl ~])
::
++  on-init
  ^-  (quip card _this)
  =^  cards  state  abet:init:hc
  [cards this]
::
++  on-save
  ^-  vase
  !>(state)
::
++  on-load
  |=  =vase
  ^-  (quip card _this)
  =^  cards  state  abet:(load:hc vase)
  [cards this]
::
++  on-poke
  |=  =cage
  ^-  (quip card _this)
  =^  cards  state  abet:(poke:hc cage)
  [cards this]
::
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  [~ ~]
::
++  on-agent
  |=  [=wire =sign:agent:gall]
  ^-  (quip card _this)
  =^  cards  state  abet:(agent:hc [wire sign])
  [cards this]
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  `this
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  =^  cards  state  abet:(watch:hc path)
  [cards this]
::
++  on-fail   on-fail:def
++  on-leave  on-leave:def
--
::
|_  [=bowl:gall deck=(list card)]
+*  that  .
::
++  emit  |=(=card that(deck [card deck]))
++  emil  |=(lac=(list card) that(deck (welp lac deck)))
++  abet  ^-((quip card _state) [(flop deck) state])
::
++  init
  ^+  that
  %-  emil
  :~
    :*  %pass  /pals  %agent
        [our.bowl %pals]  %watch  /targets
    ==
    ::
    :*  %pass   /eyre/connect   
        %arvo  %e  %connect
        `/apps/micro-doodle  %micro-doodle
    ==
    ::
    :*  %pass  /micro  %agent
        [our.bowl %micro]  %poke
        %micro-action  !>([%link '/apps/micro-doodle'])
    ==
  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
::
++  watch
  |=  =path
  ^+  that
  ?+    path  that
      [%http-response *]
    that
      [%out ~]
    ?>  (known src.bowl)
    (follow src.bowl)
  ==
::
++  known
  |=  them=ship
  ^-  ?
  =/  friends
    .^((set ship) %gx /(scot %p our.bowl)/pals/(scot %da now.bowl)/mutuals/noun)
  (~(has in friends) them)
:: 
++  poke
  |=  =cage
  ^+  that
  ?+    -.cage  !!
      %handle-http-request
    (handle-http !<([@ta =inbound-request:eyre] +.cage))
    ::
      %doodle-action
    (handle-action !<(action:doodle +.cage))    
  ==
::
++  handle-action
  |=  act=action:doodle
  ^+  that
  ?>  =(src.bowl our.bowl)
  =/  new  [our.bowl title.act pixels.act]
  =.  that  (hang new)
  (tell [/out new])
::
++  hang
  |=  =drawing:doodle
  ^+  that
  that(gallery (~(put by gallery) now.bowl drawing))
::
++  tell
  |=  [=path =drawing:doodle]
  ^+  that
  %-  emit  
  :*  %give  %fact  ~[path]
      %doodle-update 
      !>(`update:doodle`[%new drawing])
  ==  
::
++  follow
  |=  =ship
  ^+  that
  %-  emit
  [%pass /in %agent [ship dap.bowl] %watch /out]
::
++  block
  |=  =ship
  ^+  that
  %-  emil
  :~  [%give %kick ~[/out] [~ ship]]
      [%pass /in %agent [ship dap.bowl] %leave ~]
  ==
::
++  agent
  |=  [=wire =sign:agent:gall]
  ^+  that
  ?+    wire  !!
      [%pals ~]
    ?>  ?=([%fact *] sign)
    ?>  =(p.cage.sign %pals-effect)
    =/  effect  !<(effect:pals q.cage.sign)
    ?+    -.effect  !!
        %meet
      (follow ship.effect)
        %part
      (block ship.effect)
    ==
    ::
      [%in ~]
    ?+    -.sign  !!
        %kick
      %-  emit
      [%pass /in %agent [src.bowl dap.bowl] %watch /out]
      ::
        %fact
      ?>  =(p.cage.sign %doodle-update)
      =/  upd  !<(update:doodle q.cage.sign)
      =.  that  (hang drawing.upd)
      %-  emit
      :*  %pass  /micro  %agent
          [our.bowl %micro]  %poke
          %micro-action  
          !>([%bump /apps/micro-doodle/(scot %da now.bowl)])
      ==
    ==
  ==
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^+  that
  =/  ,request-line:server
    (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ::
  ?.  authenticated.inbound-request
    (emil (flop (send [302 ~ [%login-redirect './apps/micro']])))
  ?+    method.request.inbound-request
    (emil (flop (send [405 ~ [%stock ~]])))
    ::
      %'POST'
    ?~  body.request.inbound-request  !!
    =/  json  (de:json:html q.u.body.request.inbound-request)
    =/  act  (dejs-action +.json)
    (handle-action act)
    ::
      %'GET'
    %-  emil
    %-  flop
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %micro-doodle ~]
      [200 ~ [%html ui]]
    ::
        [%apps %micro-doodle %state ~]
      [200 ~ [%json (enjs-state gallery)]]
    ::
        [%apps %micro-doodle %gallery ~]
      [200 ~ [%html gallery-ui]]
    ::
        [%apps %micro-doodle @ ~]
      [200 ~ [%html view-ui]]
    ::
        [%apps %micro-doodle @ %state ~]
      =/  id  (slav %da +14:site)
      [200 ~ [%json (enjs-doodle (~(got by gallery) id))]]
    ==
  ==
::
++  enjs-state
  =,  enjs:format
  |=  [=gallery:doodle]
  ^-  json
  :-  %a
  %+  turn
    ~(tap by gallery)
  |=  [=id:doodle =drawing:doodle]
  :-  %a
  :~
      [%s (scot %da id)]
      [%s title:drawing]
      [%s (scot %p author:drawing)]
  ==
::
++  enjs-doodle
  =,  enjs:format
  |=  [=drawing:doodle]
  ^-  json
  :-  %a
  :-  [%s title:drawing]
  :-  [%s (scot %p author:drawing)]
  %+  turn  pixels:drawing
  |=  =pixel:doodle
  :-  %a
  :~  
      (numb x.pixel)
      (numb y.pixel)
      (numb order.pixel)
  ==
::
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action:doodle
  %.  jon
  %-  of
  :~  [%new (at ~[so (ar (at ~[ni ni ni]))])]
  ==
--