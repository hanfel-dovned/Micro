/-  creator
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/creator/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =apps:creator]
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
  `this
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
  %-  emit
  :*  %pass   /eyre/connect   
      %arvo  %e  %connect
      `/apps/creator  %creator
  ==
::
++  load
  |=  =vase
  ^+  that
  ?>  ?=([%0 *] q.vase)
  that(state !<(state-0 vase))
::
++  poke
  |=  =cage
  ^+  that
  ?+    -.cage  !!
      %handle-http-request
    (handle-http !<([@ta =inbound-request:eyre] +.cage))
  ==
::
++  handle-action
  |=  [=id:creator act=action:creator]
  ^+  that
  =/  app  
    ^-  app:creator  
    (~(got by apps) id)
  ?>  (~(has in transforms.app) -.act)
  =-  that(apps (~(put by apps) id [ui.app - transforms.app]))  
  ?-    -.act
      %replace-text
    (~(put by county.app) src.bowl text.act)
    ::
    ::  value as @ud isn't supported yet, so this isn't useful yet
      %add
    =/  old  (~(get by county:app) src.bowl)
    =/  num  
      ?~  old  0  u.old
    (~(put by county:app) src.bowl (add num num.act))
  ==
::
++  handle-creation
  |=  [name=@t ui=@t]
  ^+  that
  =/  old  
    ^-  (unit app:creator)  
    (~(get by apps) name)
  =/  data
    ?~  old
      ~
    county.u.old
  that(apps (~(put by apps) name [ui data (silt ~[%replace-text])]))
  ::send to relay here. need to get my url from eyre
::
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^+  that
  =/  ,request-line:server
    (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ::
  ?+    method.request.inbound-request
    (emil (flop (send [405 ~ [%stock ~]])))
    ::
      %'POST'
    ?~  body.request.inbound-request  !!
    ?+    site  (emil (flop (send [404 ~ [%plain "404 - Not Found"]])))
    ::
        [%apps %creator ~]
      ?>  =(our.bowl src.bowl)
      =/  json  (de:json:html q.u.body.request.inbound-request)
      =/  new  (dejs-creation +.json)
      =.  that  (handle-creation new)
      (emil (flop (send [200 ~ [%none ~]])))
    ::
        [%apps %creator @ ~]
      ?<  (gth src.bowl 0xffff.ffff)
      =/  json  (de:json:html q.u.body.request.inbound-request)
      =/  act  (dejs-action +.json)
      =/  id  +14:site
      =.  that  (handle-action [id act])
      (emil (flop (send [200 ~ [%none ~]])))
    ==
    ::
      %'GET'
    %-  emil
    %-  flop
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %creator ~]
      ?>  =(our.bowl src.bowl)
      [200 ~ [%html ui]]
    ::
        [%apps %creator %list-of-apps-as-json ~]
      ?>  =(our.bowl src.bowl)
      [200 ~ [%json (enjs-apps apps)]]
    ::
        [%apps %creator @ ~]
      ?:  (gth src.bowl 0xffff.ffff)
        =/  redirect
          %-  crip 
          ['/' 'apps' '/' 'creator' '/' +14:site '&eauth' ~]
        [302 ~ [%login-redirect redirect]]   
      =/  id  +14:site
      =/  app
        ^-  app:creator
        (~(got by apps) id)
      =/  fe  ui.app
      [200 ~ [%html fe]]
    ::
        [%apps %creator @ %state ~]
      ?<  (gth src.bowl 0xffff.ffff)
      =/  id  +14:site
      =/  app
        ^-  app:creator
        (~(got by apps) id)
      =/  ct  county.app
      [200 ~ [%json (enjs-county ct)]]
    ==
  ==
::
++  enjs-county
  =,  enjs:format
  |=  =county:creator
  ^-  json
  %-  pairs
  :~
      [%host [%s (scot %p our.bowl)]]
      [%user [%s (scot %p src.bowl)]]
      ::
      :-  %data
      %-  pairs
      %+  turn
        ~(tap by county)
      |=  [p=@p value=@t]
      :-  (scot %p p)
      [%s value]
  ==
::
++  enjs-apps
  =,  enjs:format
  |=  =apps:creator
  ^-  json
  %-  pairs
  %+  turn
    ~(tap by apps)
  |=  [=id:creator =app:creator]
  :-  id
  [%s ui:app]
::
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action:creator
  %.  jon
  %-  of
  :~  [%replace-text so]
      [%add ni]
  ==
::
++  dejs-creation
  =,  dejs:format
  |=  jon=json
  ^-  [@t @t]
  %.  jon
  (ot [appname+so ui+so ~])
--
