/-  micro
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/micro/html
/*  welcome  %html  /app/uis/welcome/html
/*  manifest  %webmanifest  /app/manifest/webmanifest
/*  sw  %js  /app/sw/js
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =apps:micro =new:micro =ignored:micro]
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
  %-  emil 
  :~  [%pass /eyre/connect %arvo %e %connect `/apps/micro %micro]
      :::*  %pass  /micro  %agent
      ::    [our.bowl %micro]  %poke
      ::    %micro-action  !>([%bump '/apps/micro/welcome'])
      ::==
      :::*  %pass  /micro  %agent
      ::    [our.bowl %micro]  %poke
      ::    %micro-action  !>([%link '/apps/groups'])
      ::==
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
  ==
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
    %=  that
      apps  (~(put in apps) url.act)
      new   (~(put in new) url.act)
    ==
    ::
      %unlink
    that(apps (~(del in apps) url.act))
    ::
      %bump
    ?<  (~(has in ignored) dap.bowl)
    that(new (~(put in new) url.act))
    ::
      %view
    that(new (~(del in new) url.act))
    ::
      %view-all
    that(new ~)
    ::
      %ignore
    that(ignored (~(put in ignored) agent.act))
    ::
      %unignore
    that(ignored (~(del in ignored) agent.act))
  ==
::
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
      =.  that  (handle-action act)
      %-  emil
      %-  flop
      (send [200 ~ [%json (enjs-state [apps new])]])
    ::
      %'GET'
    %-  emil
    %-  flop
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %micro ~]
      [200 ~ [%html ui]]
    ::
        [%apps %micro %state ~]
      [200 ~ [%json (enjs-state [apps new])]]
    ::
        [%apps %micro %welcome ~]
      [200 ~ [%html welcome]]
    ::
        [%apps %micro %manifest ~]
      [200 ~ [%application-json manifest]]
    ::
        [%apps %micro %sw ~]
      [200 ~ [%text-javascript sw]]
    ==
  ==
::
++  enjs-state
  |=  [=apps:micro =new:micro]
  ^-  json
  :-  %a
  :~
    :-  %a
    %+  turn
      ~(tap in apps)
    |=  =url:micro
    [%s url]
    ::
    :-  %a
    %+  turn
      ~(tap in new)
    |=  =url:micro
    [%s url]
  ==
::
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action:micro
  %.  jon
  %-  of
  :~  [%view so]
  ==
--
