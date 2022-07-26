//-----------------------------------------------ITEM ACTION---------------------------------------------------------
/obj/screen/item_action
	var/obj/item/owner

/obj/screen/item_action/Destroy()
	. = ..()
	owner = null

/obj/screen/item_action/Click()
	to_chat(usr, "start")
	if(!usr || !owner)
		return TRUE
	to_chat(usr, "checkactioncooldown")
	if(!usr.CheckActionCooldown())
		return
	to_chat(usr, "stat and restrained")
	if(usr.stat || usr.restrained())
		return TRUE
	to_chat(usr, "owner in usr")
	if(!(owner in usr))
		return TRUE
	to_chat(usr, "should be working??? [name], [owner]")
	owner.ui_action_click(usr, name)
	update_icon()
	return TRUE

/obj/screen/item_action/top_bar
	name = "actionA"
	//icon = 'icons/mob/screen/ErisStyle.dmi'
	icon_state = "actionA"
	screen_loc = "8,1:13"
	var/minloc = "7,2:13"
	layer = ABOVE_HUD_LAYER
	plane = ABOVE_HUD_PLANE

/obj/screen/item_action/top_bar/Initialize()
	. = ..()
	name = initial(name)

/obj/screen/item_action/top_bar/update_icon()
	..()
	if(!ismob(owner.loc))
		return

	var/mob/living/M = owner.loc
	if(M.client && M.get_active_hand() == owner)
		screen_loc = initial(screen_loc)


/obj/screen/item_action/top_bar/A
	icon_state = "actionA"
	screen_loc = "8,1:13"

/obj/screen/item_action/top_bar/B
	icon_state = "actionB"
	screen_loc = "8,1:13"

/obj/screen/item_action/top_bar/C
	icon_state = "actionC"
	screen_loc = "9,1:13"

/obj/screen/item_action/top_bar/D
	icon_state = "actionD"
	screen_loc = "9,1:13"


//-----------------------------------------------ITEM ACTION END---------------------------------------------------------

//-----------------------------------------------GUN ACTION--------------------------------------------------------------

/obj/screen/item_action/top_bar/gun
	icon = 'modular_coyote/eris/icons/gun_actions.dmi'
	screen_loc = "8-1:15,1+1:13"
	minloc = "7,2:13"

/obj/screen/item_action/top_bar/gun/safety
	name = "safety"
	icon_state = "safety1"

/obj/screen/item_action/top_bar/gun/safety/update_icon()
	..()
	var/obj/item/gun/G = owner
	icon_state = "safety[G.safety]"


/obj/screen/item_action/top_bar/gun/fire_mode
	name = "fire mode"
	icon_state = "mode_semi"

/obj/screen/item_action/top_bar/gun/fire_mode/update_icon()
	..()
	var/obj/item/gun/G = owner
	if(G.sel_mode <= length(G.firemodes))
		var/datum/firemode/cur_mode = G.firemodes[G.sel_mode]
		icon_state = "mode_[cur_mode.icon_state]"


/obj/screen/item_action/top_bar/gun/scope
	name = "scope"
	icon_state = "scope0"
	screen_loc = "9,1:13"
	minloc = "8,2:13"

/obj/screen/item_action/top_bar/gun/scope/update_icon()
	..()
	var/obj/item/gun/G = owner
	icon_state = "scope[G.zoomed]"


/obj/screen/item_action/top_bar/weapon_info
	icon = 'modular_coyote/eris/icons/gun_actions.dmi'
	screen_loc = "9,1+1:13"
	minloc = null
	name = "Weapon Info"
	icon_state = "info"

/*
/obj/item/gun/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, state = GLOB.default_state)
	var/list/data = ui_data(user)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "weapon_stats.tmpl", name, 700, 550, state = state)
		ui.auto_update_layout = 1
		ui.set_initial_data(data)
		ui.open()
*/
