/-  micro
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/micro/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =apps:micro =new:micro]
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
  ?>  =(src.bowl our.bowl)
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
++  emit  |=(=card that(deck [card deck]))
++  emil  |=(lac=(list card) that(deck (welp lac deck)))
++  abet  ^-((quip card _state) [(flop deck) state])
::
++  init
  ^+  that
  that
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
  (emit update)
::
++  poke
  |=  =cage
  ^+  that
  ?>  =(src.bowl our.bowl)
  ?+    -.cage  !!
      %handle-http-request
    (handle-http !<([@ta =inbound-request:eyre] +.cage))
    ::
      %micro-action
    (handle-action !<(action:micro +.cage))    
  ==
::
++  handle-action
  |=  act=action:micro
  ^+  that
  ?-    -.act
      %link
    that(apps ~(put in apps) path.act)
    ::
      %bump
    that(new ~(put in new) [now.bowl path.act priority.act])
    ::
      %view
    that(new ~(del in new) app.act)
  ==
::
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^+  that
  =/  ,request-line:servlib
    (parse-request-line:servlib url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ::
  ?.  authenticated.inbound-request
    (emil (send [302 ~ [%login-redirect './apps/micro']]))
  ?+    method.request.inbound-request
    (emil (send [405 ~ [%stock ~]]))
    ::
    ::    %'POST'
    ::  =/  json  (de-json:html q.u.body.request.inbound-request)
    ::  =/  act  (dejs-action +.json)
    ::  (handle-action act)
    ::
      %'GET'
    %-  emil
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %micro ~]
      [200 ~ [%html ui]]
    ::
        [%apps %micro %state ~]
      [200 ~ [%json (enjs-state [apps new])]]
    ==
  ==
--