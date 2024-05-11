fundot = fundot or {}
fundot.items = fundot.items or {}

local function checkForValidId( calling_ply, id )
	if id == "BOT" or id == "NULL" then -- Bot check
		return true
	elseif id:find( "%." ) then -- Assume IP and check
	 	if not ULib.isValidIP( id ) then
			ULib.tsayError( calling_ply, "Invalid IP.", true )
			return false
		end
	elseif id:find( ":" ) then
	 	if not ULib.isValidSteamID( id ) then -- Assume steamid and check
			ULib.tsayError( calling_ply, "Invalid steamid.", true )
			return false
		end
	elseif not tonumber( id ) then -- Assume uniqueid and check
		ULib.tsayError( calling_ply, "Invalid Unique ID", true )
		return false
	end

	return true
end

function ulx.userallowid( calling_ply, id, access_string, access_tag )
	if access_tag then access_tag = access_tag end
	id = id:upper() -- Steam id needs to be upper

	-- Check for valid and properly formatted ID
	if not checkForValidId( calling_ply, id ) then return false end

	if not ULib.ucl.authed[ id ] and not ULib.ucl.users[ id ] then
        ULib.ucl.addUser(id, {}, {}, 'fellow')
		ULib.tsay( calling_ply, "No player with id \"" .. id .. "\" exists in the ULib user list, adding...", true )
	end

	local accessTable
	if access_tag and access_tag ~= "" then
		accessTable = { [access_string]=access_tag }
	else
		accessTable = { access_string }
	end

	local success = ULib.ucl.userAllow( id, accessTable )
	local name = (ULib.ucl.authed[ id ] and ULib.ucl.authed[ id ].name) or (ULib.ucl.users[ id ] and ULib.ucl.users[ id ].name) or id
	if not success then
		ULib.tsayError( calling_ply, string.format( "User \"%s\" already has access to \"%s\"", name, access_string ), true )
	else
		if not access_tag or access_tag == "" then
			ulx.fancyLogAdmin( calling_ply, "#A granted access #q to #s", access_string, name )
		else
			ulx.fancyLogAdmin( calling_ply, "#A granted access #q with tag #q to #s", access_string, access_tag, name )
		end
	end
end
local userallowid = ulx.command( CATEGORY_NAME, "ulx userallowid", ulx.userallowid, nil, false, false, true )
userallowid:addParam{ type=ULib.cmds.StringArg, hint="SteamID, IP, or UniqueID" }
userallowid:addParam{ type=ULib.cmds.StringArg, hint="command" } -- TODO, add completes for this
userallowid:addParam{ type=ULib.cmds.StringArg, hint="access tag", ULib.cmds.optional }
userallowid:defaultAccess( ULib.ACCESS_SUPERADMIN )
userallowid:help( "Add to a user's access." )