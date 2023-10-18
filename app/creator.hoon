/-  creator, relay
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/creator/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =apps:creator blocked=(set ship)]
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
      %creator-create-action
    (handle-create-action !<(create-action:creator +.cage))
  ==
::
++  handle-app-action
  |=  [=id:creator act=app-action:creator]
  ^+  that
  ?<  (gth src.bowl 0xffff.ffff)
  =/  app  
    ^-  app:creator  
    (~(got by apps) id)
  =-  that(apps (~(put by apps) id [ui.app - published.app]))  
  ?-    -.act
      %put-in-map
    %+  ~(put by county.app) 
      src.bowl
    =/  user-map  (~(get by county.app) src.bowl)
    ?~  user-map
      (malt (limo [key.act value.act]~))
    (~(put by u.user-map) key.act value.act)
  ==
::
++  handle-create-action
  |=  act=create-action:creator
  ^+  that
  ?>  =(src.bowl our.bowl)
  ?-    -.act
      %save
    =/  old  
      ^-  (unit app:creator)  
      (~(get by apps) id.act)
    =/  ct
      ?~  old  ~
      county.u.old
    =/  pb
      ?~  old  %.n
      published.u.old
    that(apps (~(put by apps) id.act [ui.act ct pb]))
  ::
      %publish
    =/  old  
      ^-  app:creator
      (~(got by apps) id.act)
    =/  ct  county.old
    =/  ui  ui.old
    =.  that
      that(apps (~(put by apps) id.act [ui ct %.y]))
    (poke-relay [%publish url.act])
  ::
      %unpublish
    =/  old  
      ^-  app:creator
      (~(got by apps) id.act)
    =/  ct  county.old
    =/  ui  ui.old
    =.  that
      that(apps (~(put by apps) id.act [ui ct %.n]))
    (poke-relay [%unpublish url.act])
  ::
      %block-user
    that(blocked (~(put in blocked) ship.act))
  ::
      %unblock-user
    that(blocked (~(del in blocked) ship.act))
  ::
      %destroy-app
    that(apps (~(del by apps) id.act))
    ::also unpublish. need my url from eyre
  ::
      %delete-user-data
    =/  old  
      ^-  app:creator
      (~(got by apps) id.act)
    =/  pb  published.old
    =/  ui  ui.old
    =/  ct  (~(del by county.old) ship.act)
    that(apps (~(put by apps) id.act [ui ct pb]))
  ==
::
++  poke-relay
  |=  =action:relay
  ^+  that
  %-  emit
  :*  %pass  /publish 
      %agent  [~ridlyd %relay] 
      %poke  %relay-action
      !>(action)
  ==
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
      =/  act  (dejs-create-action +.json)
      =.  that  (handle-create-action act)
      (emil (flop (send [200 ~ [%none ~]])))
    ::
        [%apps %creator @ ~]
      ?<  (gth src.bowl 0xffff.ffff) ::must be a planet to POST
      =/  json  (de:json:html q.u.body.request.inbound-request)
      =/  act  (dejs-app-action +.json)
      =/  id  +14:site
      =/  app
        ^-  app:creator
        (~(got by apps) id)
      ?>  ?|  =(%.y published.app)
              =(src.bowl our.bowl)
          ==
      =.  that  (handle-app-action [id act])
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
      =/  id  +14:site
      =/  app
        ^-  app:creator
        (~(got by apps) id)
      ?>  ?|  =(%.y published.app)
              =(src.bowl our.bowl)
          ==
      =/  fe  ui.app
      [200 ~ [%html fe]]
    ::
        [%apps %creator @ %state ~]
      =/  id  +14:site
      =/  app
        ^-  app:creator
        (~(got by apps) id)
      ?>  ?|  =(%.y published.app)
              =(src.bowl our.bowl)
          ==
      =/  ct  county.app
      [200 ~ [%json (enjs-county ct)]]
    ::
        [%apps %creator @ %eauth ~]
      =/  redirect
        %-  crip 
        ['/' 'apps' '/' 'creator' '/' +14:site '&eauth' ~]
      [302 ~ [%login-redirect redirect]] 
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
      |=  [user=@p m=(map =key:creator =value:creator)]
      :-  (scot %p user)
      %-  pairs
      %+  turn
        ~(tap by m)
      |=  [=key:creator =value:creator]
      :-  key
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
  %-  pairs
  :~  [%ui [%s ui:app]]
      [%published [%b published:app]]
  ==
::
++  dejs-app-action
  =,  dejs:format
  |=  jon=json
  ^-  app-action:creator
  %.  jon
  %-  of
  :~  [%put-in-map (ot ~[key+so value+so])]  
  ==
::
++  dejs-create-action
  =,  dejs:format
  |=  jon=json
  ^-  create-action:creator
  %.  jon
  %-  of
  :~  [%save (ot ~[id+so ui+so])]  
      [%publish (ot ~[id+so url+so])]
      [%unpublish (ot ~[id+so url+so])]
      [%block-user (ot ~[user+(se %p)])]
      [%unblock-user (ot ~[user+(se %p)])]
      [%destroy-app (ot ~[id+so])]
      [%delete-user-data (ot ~[id+so user+(se %p)])]  
  ==
--