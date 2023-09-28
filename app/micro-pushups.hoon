/-  pushups, pals
/+  dbug, default-agent, server, schooner
::  /*  ui  %html  /app/pushups/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =scores:pushups]
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
  `this
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
  =>  that(scores (~(put by scores) our.bowl [0 0]))
  %-  emil
  :~
    :*  %pass  /pals  %agent
        [our.bowl %pals]  %watch  /targets
    ==
    :*  %pass   /eyre/connect   
        %arvo  %e  %connect
        `/apps/micro-pushups  %micro-pushups
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
    (follow src.bowl):(tell ~)
  ==
::
++  known
  |=  them=ship
  ^-  ?
  =/  friends
    .^((set ship) %gx /(scot %p our.bowl)/pals/(scot %da now.bowl)/mutuals)
  (~(has in friends) them)
:: 
++  poke
  |=  =cage
  ^+  that
  ?+    -.cage  !!
    ::  %handle-http-request
    ::(handle-http !<([@ta =inbound-request:eyre] +.cage))
    ::
      %pushups-action
    (handle-action !<(action:pushups +.cage))    
  ==
::
++  handle-action
  |=  act=action:pushups
  ^+  that
  ?>  =(src.bowl our.bowl)
  (tell /out):(tally points.act)
::
++  mine  
  ^-  score:pushups
  (~(got by scores) our.bowl)
::
++  tally
  |=  points=@ud
  ^+  that
  =/  old  mine
  =/  new  [(add day.old points) (add life.old points)]
  that(scores (~(put by scores) our.bowl new))
::
++  tell
  |=  =path
  ^+  that
  %-  emit  
  :*  %give  %fact  ~[path]
      %pushups-update 
      !>(`update:pushups`[%score mine])
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
      ?>  =(p.cage.sign %pushups-update)
      =/  upd  !<(update:pushups q.cage.sign)
      that(scores (~(put by scores) src.bowl score.upd))
    ==
  ==
::++  handle-http
::  |=  [eyre-id=@ta =inbound-request:eyre]
::  ^+  that
::  =/  ,request-line:server
::    (parse-request-line:server url.request.inbound-request)
::  =+  send=(cury response:schooner eyre-id)
::  ::
::  ?.  authenticated.inbound-request
::    (emil (flop (send [302 ~ [%login-redirect './apps/micro']])))
::  ?+    method.request.inbound-request
::    (emil (flop (send [405 ~ [%stock ~]])))
::    ::
::    ::    %'POST'
::    ::  =/  json  (de-json:html q.u.body.request.inbound-request)
::    ::  =/  act  (dejs-action +.json)
::    ::  (handle-action act)
::    ::
::      %'GET'
::    %-  emil
::    %-  flop
::    %-  send
::    ?+    site  [404 ~ [%plain "404 - Not Found"]]
::    ::
::        [%apps %micro ~]
::      [200 ~ [%html ui]]
::    ::
::        [%apps %micro %state ~]
::      [200 ~ [%json (enjs-state [apps new])]]
::    ==
::  ==
::
::++  enjs-state
::  |=  [=apps:micro =new:micro]
::  ^-  json
::  :-  %a
::  :~
::    :-  %a
::    %+  turn
::      ~(tap in apps)
::    |=  p=path
::    (path:enjs:format p)
::    ::
::    :-  %a
::    %+  turn
::      ~(tap in new)
::    |=  [=id:micro =path =priority:micro]
::    :-  %a
::    :~
::        [%s (scot %da id)]
::        (path:enjs:format path)
::        (numb:enjs:format priority)
::    ==
::  ==
--