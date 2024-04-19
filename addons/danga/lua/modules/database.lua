require 'mysqloo'

CFG = CFG or {}

local config = {
	host = '45.136.205.248',
	user = 'u2_igyvobU6yB',
	password = 'r=tQan+Y5LHi+OJS^^b5DW8D',
    database = 's2_server',
    port = 3306,
    socket = '',
}

function dangautils.reconnectDB()

	dangautils.console('DB: Connecting...')

	local db = mysqloo.CreateDatabase(config.host, config.user, config.password, config.database, config.port, config.socket)
	function db:onConnected()
		dangautils.console('DB: Connected.')
		dangautils.db = db
		dangautils.db:RunQuery('SET NAMES utf8')

		timer.Create('dangautils.db.heartbeat', 30, 0, function()
			local status = dangautils.db:status()
			if status ~= mysqloo.DATABASE_CONNECTED and status ~= mysqloo.DATABASE_CONNECTED then
				dangautils.reconnectDB()
				timer.Remove('dangautils.db.heartbeat')
			end
		end)
		hook.Run('dangautils.db.init', db)
	end

	function db:onConnectionFailed(data)
		dangautils.console('DB: Connection failed: ')
		print(data)

		dangautils.console('DB: Reconnecting in 30 seconds...')
		timer.Simple(30, dangautils.reconnectDB)

		timer.Remove('dangautils.db.heartbeat')
	end

end

hook.Add('dangautils.run', 'dangautils', function()
	dangautils.reconnectDB()
end)