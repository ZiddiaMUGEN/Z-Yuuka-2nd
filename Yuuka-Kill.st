[Statedef 11223342]
movetype = A

[State 11223342]
type = Explod
triggerall = Ctrl
trigger1 = Pos x >= 0
trigger1 = !NumExplod(11223342)
id = 11223342
anim = 1020
postype = p1
pos = 0,-30
sprpriority = 0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = Explod
triggerall = Ctrl
trigger1 = Pos x >= 0
trigger1 = (GameTime % 2) = 0
id = 11223343
anim = 6000 + ((random % 9) * 10)
postype = p1
pos = 0, 0
random = 400, 400
removetime = -2
sprpriority = 0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = PlaySnd
triggerall = Ctrl
trigger1 = Pos x >= 0
trigger1 = (sysvar(1) % 190) = 1
value = 900,3
ignorehitpause = 1
persistent = 256

[State 11223342]
type = PlaySnd
triggerall = Ctrl
trigger1 = Anim = 20
trigger1 = (GameTime % 30) = 0
value = 40,0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = PlaySnd
triggerall = Ctrl
trigger1 = sysvar(1) = 256
value = 900,4
ignorehitpause = 1
persistent = 256

[State 11223342]
type = VarAdd
triggerall = Ctrl
trigger1 = Pos x >= 0
sysvar(1) = 1
ignorehitpause = 1
persistent = 256

[State 11223342]
type = ChangeAnim
trigger1 = Pos x < 0
trigger1 = Anim != 20
value = 20
ignorehitpause = 1
persistent = 256

[State 11223342]
type = ChangeAnim
trigger1 = Pos x >= 0
trigger1 = sysvar(1) < 256
trigger1 = Anim != 0
value = 0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = ChangeAnim
trigger1 = Pos x >= 0
trigger1 = sysvar(1) >= 256
trigger1 = Anim != 181
value = 181
ignorehitpause = 1
persistent = 256

[State 11223342]
type = PosSet
trigger1 = RoundState < 4
trigger1 = !Ctrl
x = -220
y = 0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = VelSet
trigger1 = Ctrl
trigger1 = Pos x < 0
x = 0.3
y = 0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = PosSet
trigger1 = Ctrl
trigger1 = Pos x >= 0
x = 0
y = 0
ignorehitpause = 1
persistent = 256

[State 11223342]
type = VelSet
trigger1 = Ctrl
trigger1 = Pos x >= 0
x = 0
y = 0
ignorehitpause = 1
persistent = 256

;; complicated.
;; 1. set their Alive to 0
;; 2. restore them as Players
;; 3. freeze them
[State 11223342, Kill MUGEN 1.1]
type = Null
triggerall = var(2) != 0 ; MUGEN 1.1
triggerall = sysvar(1) >= 256
trigger1 = var(11) != 0
trigger1 = (var(var(11) + 3840) := 0) || 1 ;; alive
trigger1 = (var(var(11) + 28) := 0) || 1 ;; IsHelper
trigger1 = (var(var(11) + 436) := 1) && 0 ;; Freeze
trigger2 = var(12) != 0
trigger2 = (var(var(12) + 3840) := 0) || 1 ;; alive
trigger2 = (var(var(12) + 28) := 0) || 1 ;; IsHelper
trigger2 = (var(var(12) + 436) := 1) || 1 ;; Freeze
ignorehitpause = 1
persistent = 256
[State 11223342, Kill MUGEN 1.0]
type = Null
triggerall = var(2) = 0 ; MUGEN 1.0
triggerall = sysvar(1) >= 256
trigger1 = var(11) != 0
trigger1 = (var(var(11) + 3712) := 0) || 1 ;; alive
trigger1 = (var(var(11) + 28) := 0) || 1 ;; IsHelper
trigger1 = (var(var(11) + 436) := 1) && 0 ;; Freeze
trigger2 = var(12) != 0
trigger2 = (var(var(12) + 3712) := 0) || 1 ;; alive
trigger2 = (var(var(12) + 28) := 0) || 1 ;; IsHelper
trigger2 = (var(var(12) + 436) := 1) || 1 ;; Freeze
ignorehitpause = 1
persistent = 256

[Statedef 11223343]
movetype = A

[State 11223343, Delete Helper MUGEN 1.1]
type = Null
triggerall = var(2) != 0 ; MUGEN 1.1
trigger1 = var(3) := var(var(5259496) + 74360 + 4*var(1)) || 1 ;; helper addr
trigger1 = var(3) != 0 ;; security
trigger1 = var(var(3) + 432) := 0 || 1 ;; set exist flag
ignorehitpause = 1
persistent = 256

[State 11223343, Delete Helper MUGEN 1.0]
type = Null
triggerall = var(2) = 0 ; MUGEN 1.0
trigger1 = var(3) := var(var(5420044) + 70196 + 4*var(1)) || 1 ;; helper addr
trigger1 = var(3) != 0 ;; security
trigger1 = var(var(3) + 432) := 0 || 1 ;; set exist flag
ignorehitpause = 1
persistent = 256

[State 11223343, Loop All Helpers]
type = ChangeState
trigger1 = var(1) < 59
trigger1 = (var(1) := var(1) + 1) || 1
value = StateNo
ignorehitpause = 1
persistent = 256

[State 11223343, Goto Mgmt]
type = ChangeState
trigger1 = 1
value = 11223342
ignorehitpause = 1
persistent = 256

[Statedef 11223344]

[State 11223344]
type = ChangeAnim
trigger1 = SelfAnimExist(170)
trigger1 = Anim != 170
value = 170
ignorehitpause = 1
persistent = 256

[State 11223344]
type = ChangeAnim
trigger1 = !SelfAnimExist(170)
trigger1 = Anim != 5002
value = 5002
ignorehitpause = 1
persistent = 256

[State 11223344]
type = PosSet
trigger1 = enemy(enemy,Name != "Z-Yuuka"),var(12) = 0
x = -100
y = 0
ignorehitpause = 1
persistent = 256

[State 11223344]
type = PosSet
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(2) != 0 ; MUGEN 1.1
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(12) != 0
trigger1 = (var(1) := var(enemy(enemy,Name != "Z-Yuuka"),var(12) + 4)) || 1 ;; retrieve possible partner ID
x = ifelse(var(1) = var(-966), Const240p(100), Const240p(-100))
y = 0
ignorehitpause = 1
persistent = 256

[State 11223344]
type = Turn
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(2) != 0 ; MUGEN 1.1
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(12) != 0
trigger1 = var(1) = var(-966)
trigger1 = Facing = -1
trigger2 = var(1) != var(-966)
trigger2 = Facing = 1
ignorehitpause = 1
persistent = 256

[State 11223344]
type = PosSet
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(2) = 0 ; MUGEN 1.0
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(12) != 0
trigger1 = (var(1) := var(enemy(enemy,Name != "Z-Yuuka"),var(12) + 4)) || 1 ;; retrieve possible partner ID
x = ifelse(var(1) = var(-934), Const240p(100), Const240p(-100))
y = 0
ignorehitpause = 1
persistent = 256

[State 11223344]
type = Turn
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(2) = 0 ; MUGEN 1.0
triggerall = enemy(enemy,Name != "Z-Yuuka"),var(12) != 0
trigger1 = var(1) = var(-934)
trigger1 = Facing = -1
trigger2 = var(1) != var(-934)
trigger2 = Facing = 1
ignorehitpause = 1
persistent = 256

[State 11223344]
type = Trans
trigger1 = 1
trans = addalpha
alpha = 0 + (enemy(enemy,Name != "Z-Yuuka"),sysvar(1)),256 - (enemy(enemy,Name != "Z-Yuuka"),sysvar(1))
ignorehitpause = 1
persistent = 256

[State 11223344]
type = DisplayToClipboard
trigger1 = 1
text="P=%d X=%d Y=%d Alive=%d Life=%d PID=%d"
params = root,NumPartner, Pos x, Pos y, Alive, Life, var(1)
ignorehitpause = 1
persistent = 256