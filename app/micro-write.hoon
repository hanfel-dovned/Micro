/-  write, pals
/+  dbug, default-agent, server, schooner
/*  ui  %html  /app/uis/write/html
/*  view-ui  %html  /app/uis/write-view/html
::
|%
::
+$  versioned-state  $%(state-0)
::
+$  state-0  [%0 =library:write]
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
    behn
    ::
    :*  %pass  /pals  %agent
        [our.bowl %pals]  %watch  /targets
    ==
    ::
    :*  %pass   /eyre/connect   
        %arvo  %e  %connect
        `/apps/micro-write  %micro-write
    ==
  ==
::
++  behn
  ^-  card
  =/  today=@da
    (yule [d=d:(yell now.bowl) h=0 m=0 s=0 f=~[0x0]])
  [%pass /timer %arvo %b %wait (add today ~d1)]
::
++  arvo
  |=  [=wire =sign-arvo]
  ^+  that
  ?+    wire  !!
      [%timer ~]
    ?+    sign-arvo  !!
        [%behn %wake *]
      =.  that  (emit behn)
      %-  emit
      :*  %pass  /micro  %agent
          [our.bowl %micro]  %poke
          %micro-action  
          !>([%bump /apps/micro-write])
      ==
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
      %write-action
    (handle-action !<(action:write +.cage))    
  ==
::
++  handle-action
  |=  act=action:write
  ^+  that
  ?>  =(src.bowl our.bowl)
  =/  new  [our.bowl prompt.act text.act]
  =.  that  (shelve new)
  (tell [/out new])
::
++  shelve
  |=  =entry:write
  ^+  that
  that(library (~(put by library) now.bowl entry))
::
++  tell
  |=  [=path =entry:write]
  ^+  that
  %-  emit  
  :*  %give  %fact  ~[path]
      %write-update 
      !>(`update:write`[%new entry])
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
      ?>  =(p.cage.sign %write-update)
      =/  upd  !<(update:write q.cage.sign)
      =.  that  (shelve entry.upd)
      %-  emit
      :*  %pass  /micro  %agent
          [our.bowl %micro]  %poke
          %micro-action  
          !>([%bump /apps/micro-write/(scot %da now.bowl)])
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
    =.  that  (handle-action act)
    %-  emil
    %-  flop
    (send [200 ~ [%none ~]])
    ::
      %'GET'
    %-  emil
    %-  flop
    %-  send
    ?+    site  [404 ~ [%plain "404 - Not Found"]]
    ::
        [%apps %micro-write ~]
      [200 ~ [%html ui]]
    ::
        [%apps %micro-write %prompt ~]
      [200 ~ [%json enjs-prompt]]
    ::
        [%apps %micro-write @ ~]
      [200 ~ [%html view-ui]]
    ::
        [%apps %micro-write @ %state ~]
      =/  id  (slav %da +14:site)
      [200 ~ [%json (enjs-entry (~(got by library) id))]]
    ==
  ==
::
++  enjs-prompt
  =,  enjs:format
  ^-  json
  :-  %s
  =/  i  (mod d:(yell now.bowl) 365)
  (snag i prompts)
::
++  enjs-entry
  =,  enjs:format
  |=  [=entry:write]
  ^-  json
  :-  %a
  :~
    [%s prompt:entry]
    [%s (scot %p author:entry)]
    [%s text:entry]
  ==
::
++  dejs-action
  =,  dejs:format
  |=  jon=json
  ^-  action:write
  %.  jon
  %-  of
  :~  [%new (at ~[so so])]
  ==
::
++  prompts
  ^-  (list @t)
  :~
    'apple'
    'book'
    'cat'
    'dog'
    'elephant'
    'friend'
    'guitar'
    'house'
    'island'
    'jump'
    'kite'
    'love'
    'moon'
    'night'
    'ocean'
    'pencil'
    'queen'
    'rain'
    'sun'
    'tree'
    'umbrella'
    'violin'
    'water'
    'xylophone'
    'yellow'
    'zebra'
    'adventure'
    'beach'
    'coffee'
    'dream'
    'energy'
    'family'
    'goal'
    'happiness'
    'intelligence'
    'justice'
    'knowledge'
    'laughter'
    'memory'
    'novel'
    'optimism'
    'peace'
    'quiet'
    'respect'
    'success'
    'travel'
    'unity'
    'victory'
    'wisdom'
    'xenophobia'
    'yoga'
    'zoo'
    'art'
    'bird'
    'cake'
    'dance'
    'emotion'
    'freedom'
    'garden'
    'hero'
    'ice'
    'journey'
    'kindness'
    'light'
    'music'
    'nature'
    'opinion'
    'passion'
    'question'
    'river'
    'story'
    'time'
    'universe'
    'voice'
    'window'
    'x-ray'
    'youth'
    'zero'
    'actor'
    'belief'
    'chocolate'
    'discovery'
    'effort'
    'flower'
    'grace'
    'history'
    'idea'
    'job'
    'key'
    'life'
    'mountain'
    'noise'
    'opportunity'
    'patience'
    'quality'
    'relationship'
    'space'
    'thought'
    'utopia'
    'vacation'
    'wealth'
    'experience'
    'yearning'
    'zone'
    'age'
    'beauty'
    'courage'
    'doubt'
    'education'
    'faith'
    'growth'
    'home'
    'inspiration'
    'joy'
    'kind'
    'loss'
    'mind'
    'need'
    'observation'
    'purpose'
    'quietude'
    'reason'
    'soul'
    'trust'
    'understanding'
    'virtue'
    'wonder'
    'excitement'
    'yes'
    'zest'
    'ambition'
    'balance'
    'change'
    'desire'
    'endurance'
    'fear'
    'gratitude'
    'honor'
    'integrity'
    'justice'
    'leadership'
    'mystery'
    'novelty'
    'openness'
    'pride'
    'quarrel'
    'rest'
    'simplicity'
    'talent'
    'uncertainty'
    'vision'
    'work'
    'x-factor'
    'year'
    'zenith'
    'achievement'
    'bliss'
    'comfort'
    'dedication'
    'empowerment'
    'forgiveness'
    'generosity'
    'humor'
    'innovation'
    'judgment'
    'legacy'
    'motivation'
    'nurture'
    'obstacle'
    'potential'
    'quest'
    'resilience'
    'serenity'
    'transformation'
    'valor'
    'wisdom'
    'xenophile'
    'yawn'
    'zeal'
    'aspiration'
    'boundary'
    'commitment'
    'determination'
    'enthusiasm'
    'fulfillment'
    'guidance'
    'humility'
    'individuality'
    'karma'
    'liberty'
    'maturity'
    'necessity'
    'optimist'
    'perseverance'
    'quintessence'
    'revelation'
    'stability'
    'thankfulness'
    'update'
    'vulnerability'
    'wellness'
    'expectation'
    'yesterday'
    'zephyr'
    'error'
    'index'
    'list'
    'number'
    'accountability'
    'bravery'
    'clarity'
    'diversity'
    'empower'
    'flexibility'
    'harmony'
    'impact'
    'judicious'
    'loyalty'
    'mindfulness'
    'nuance'
    'originality'
    'precision'
    'quality'
    'resourcefulness'
    'sustainability'
    'tenacity'
    'utility'
    'versatility'
    'willingness'
    'xenial'
    'yen'
    'zestful'
    'adaptability'
    'boldness'
    'civility'
    'diligence'
    'eloquence'
    'frugality'
    'humanity'
    'ingenuity'
    'jovial'
    'luminous'
    'magnanimity'
    'neutrality'
    'objectivity'
    'pragmatism'
    'quixotic'
    'refinement'
    'spontaneity'
    'tact'
    'uniqueness'
    'vivacity'
    'wit'
    'xenodochial'
    'yielding'
    'zealous'
    'articulate'
    'buoyant'
    'cohesive'
    'dynamic'
    'efficacious'
    'fervent'
    'gregarious'
    'holistic'
    'inquisitive'
    'jubilant'
    'keen'
    'lucid'
    'meticulous'
    'nimble'
    'observant'
    'proactive'
    'quintessential'
    'regal'
    'sagacious'
    'thrifty'
    'unflappable'
    'vigilant'
    'wholesome'
    'xerophyte'
    'yearn'
    'zippy'
    'astute'
    'blithe'
    'conscientious'
    'devoted'
    'ebullient'
    'fastidious'
    'gratifying'
    'heartwarming'
    'illustrious'
    'jocular'
    'knack'
    'laudable'
    'munificent'
    'nurturing'
    'outgoing'
    'philanthropic'
    'quiescent'
    'reverent'
    'scrupulous'
    'temperate'
    'unassuming'
    'valiant'
    'winsome'
    'xeniality'
    'yare'
    'zephyrous'
    'audacious'
    'benign'
    'convivial'
    'dexterous'
    'equanimous'
    'flourishing'
    'halcyon'
    'invigorating'
    'jocund'
    'kinetic'
    'lenient'
    'magnificent'
    'nonchalant'
    'omniscient'
    'placid'
    'quorum'
    'resilient'
    'sanguine'
    'tranquil'
    'urbane'
    'venerable'
    'wistful'
    'xenophile'
    'youthful'
    'zealot'
    'acumen'
    'boisterous'
    'cryptic'
    'defiant'
    'elusive'
    'flamboyant'
    'gallant'
    'heedful'
    'incisive'
    'juxtapose'
    'kudos'
    'lament'
    'morose'
    'negligent'
    'opaque'
    'pensive'
    'quandary'
    'retrospect'
    'sardonic'
    'tumultuous'
    'ubiquitous'
    'vehemence'
    'wary'
    'xenophobic'
    'yokel'
    'zany'
    'ardor'
    'brusque'
    'complacent'
    'disdain'
    'ephemeral'
    'facetious'
    'glib'
    'hubris'
    'indolent'
    'jaded'
    'knave'
    'loquacious'
    'maudlin'
    'nonplussed'
    'obtuse'
    'pedantic'
    'quibble'
    'renounce'
    'sycophant'
    'trite'
    'unctuous'
    'voracious'
    'wheedle'
    'xenogenesis'
    'yammer'
    'zeppelin'
    'aplomb'
    'bombastic'
    'capitulate'
    'deride'
    'exacerbate'
    'fickle'
    'grandiose'
    'haughty'
    'insipid'
    'jovial'
    'knell'
    'lugubrious'
    'mundane'
    'noxious'
    'obfuscate'
    'perfidious'
    'quintuple'
    'repudiate'
    'stymie'
    'tenuous'
    'usurp'
    'vicarious'
    'wistful'
    'xerox'
    'yen'
    'zilch'
    'aberration'
    'blatant'
    'conundrum'
    'deplete'
    'extricate'
    'futile'
    'gregarious'
    'harangue'
    'inept'
    'jargon'
    'kinetic'
    'lethargic'
    'malaise'
    'nuance'
    'oblivion'
    'paradox'
    'quagmire'
    'rescind'
    'sporadic'
    'taciturn'
    'undermine'
    'vex'
    'wane'
    'xenolith'
    'yore'
    'zeitgeist'
  ==
--